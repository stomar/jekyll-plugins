module Jekyll

  module PathCreator

    # Creates a path relative to the site root directory.
    #
    # +page_dir+ - directory of the current page
    # +path+ - path to a file (relative to page or absolute)
    #
    # Returns the path as string.
    def self.create(page_dir, path)
      is_relative = (path !~ /\A\//)
      path_from_root = is_relative ? File.join(page_dir, path) : path

      path_from_root.gsub(/\A\//, '')
    end
  end

  # A tag that generates a link (in markdown format) to a local file
  # with its basename as link text. When the file can not be found
  # the tag only generates the basename without a link.
  #
  # Usage:
  #
  #     {% file_link path/to/file %}  # => [file](path/to/file)
  #     {% file_link /path/to/file %} # => [file](/path/to/file)
  #
  # The path can be given relative (to the current page)
  # or absolute, with the Jekyll source directory as root.
  #
  # Installation:
  #
  # Copy this file into the +_plugins+ directory.
  #
  # Copyright (C) 2012 Marcus Stollsteimer
  #
  # License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  class FileLinkTag < Liquid::Tag

    def initialize(tag_name, path, tokens)
      super
      @path = path.strip
      @basename = File.basename(@path)
    end

    def render(context)
      page = context.environments.first['page']
      page_dir = File.dirname(page['url'])
      path = PathCreator.create(page_dir, @path)

      if File.exist?(path)
        out = "[#{@basename}](#{@path})"
      else
        out = @basename
        warn "file_link plugin: File not found: `#{path}'"
      end

      out
    end
  end
end

Liquid::Template.register_tag('file_link', Jekyll::FileLinkTag)
