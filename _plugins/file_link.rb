# frozen_string_literal: true

module Jekyll

  # Helper module.
  module PathCreator

    # Creates a path relative to the site root directory.
    #
    # +page_dir+ - directory of the current page
    # +path+ - path to a file (relative to page or absolute)
    #
    # Returns the path as string.
    def self.create(page_dir, path)
      is_relative = (path !~ %r{\A/})
      path_from_root = is_relative ? File.join(page_dir, path) : path

      path_from_root.gsub(%r{\A/}, "")
    end
  end

  # A tag that generates a link (in markdown format) to a local file
  # with its basename as link text. When the file cannot be found
  # the tag only generates the basename without a link.
  #
  # Usage:
  #
  #     {% file_link path/to/file %}  # => [file](path/to/file)
  #     {% file_link /path/to/file %} # => [file](/path/to/file)
  #     {% file_link no/such/file %}  # => file
  #
  # The path can be given relative (to the current page)
  # or absolute, with the Jekyll source directory as root.
  #
  # Installation:
  #
  # Copy this file into the +_plugins+ directory.
  #
  # Copyright (C) 2012-2018 Marcus Stollsteimer
  #
  # License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  class FileLinkTag < Liquid::Tag

    def initialize(tag_name, path, tokens)
      super
      @path = path.strip
      @basename = File.basename(@path)
    end

    def page_dir(page)
      url = page["url"]

      if url.end_with?("/")
        url.chop
      else
        File.dirname(url)
      end
    end

    def render(context)
      page = context.environments.first["page"]
      path = PathCreator.create(page_dir(page), @path)

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

Liquid::Template.register_tag("file_link", Jekyll::FileLinkTag)
