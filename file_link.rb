module Jekyll

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

    def initialize(tag_name, text, tokens)
      super
      @path = text.strip
      @basename = File.basename(@path)
    end

    def render(context)
      page = context.environments.first['page']
      page_dir = File.dirname(page['url'])

      # create path relative to site root
      path = path_relative? ? File.join(page_dir, @path) : @path
      path.gsub!(%r{\A/}, '')

      if File.exist?(path)
        out = "[#{@basename}](#{@path})"
        #out = "<a href='#{@path}'>#{@basename}</a>"
      else
        out = @basename
        warn "file_link plugin: File not found: `#{path}'"
      end

      out
    end

    private

    def path_relative?
      !(%r{\A/} =~ @path)
    end
  end
end

Liquid::Template.register_tag('file_link', Jekyll::FileLinkTag)
