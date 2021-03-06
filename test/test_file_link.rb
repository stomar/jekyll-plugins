# test_file_link.rb: Unit tests for the file_link tag.
#
# Copyright (C) 2012-2017 Marcus Stollsteimer

require 'minitest/autorun'
require 'liquid'
require 'file_link'


describe Jekyll::PathCreator do

  it 'can handle a relative path from root' do
    Jekyll::PathCreator.create('/', 'path/to/file').must_equal 'path/to/file'
  end

  it 'can handle an absolute path from root' do
    Jekyll::PathCreator.create('/', '/path/to/file').must_equal 'path/to/file'
  end

  it 'can handle a relative path from a subdirectory' do
    Jekyll::PathCreator.create('/page/dir', 'path/to/file').must_equal 'page/dir/path/to/file'
  end

  it 'can handle an absolute path from a subdirectory' do
    Jekyll::PathCreator.create('/page/dir', '/path/to/file').must_equal 'path/to/file'
  end
end
