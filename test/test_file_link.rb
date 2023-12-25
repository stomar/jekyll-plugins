# test_file_link.rb: Unit tests for the file_link tag.

require 'minitest/autorun'
require 'liquid'
require 'file_link'


describe Jekyll::PathCreator do

  it 'can handle a relative path from root' do
    _(Jekyll::PathCreator.create('/', 'path/to/file')).must_equal 'path/to/file'
  end

  it 'can handle an absolute path from root' do
    _(Jekyll::PathCreator.create('/', '/path/to/file')).must_equal 'path/to/file'
  end

  it 'can handle a relative path from a subdirectory' do
    _(Jekyll::PathCreator.create('/page/dir', 'path/to/file')).must_equal 'page/dir/path/to/file'
  end

  it 'can handle an absolute path from a subdirectory' do
    _(Jekyll::PathCreator.create('/page/dir', '/path/to/file')).must_equal 'path/to/file'
  end
end
