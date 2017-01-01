# test_localize.rb: Unit tests for the localize filter.
#
# Copyright (C) 2013-2017 Marcus Stollsteimer

require 'minitest/autorun'
require 'liquid'
require 'localize'

include Jekyll::LocalizeFilter

describe Jekyll::LocalizeFilter do

  before do
    @env_de  = [ { 'page' => {'lang' => 'de'} } ]
    @env_nil = [ { 'page' => {} } ]

    @context = MiniTest::Mock.new
  end

  it 'localizes a relative link for given lang' do
    @context.expect(:environments, @env_de)
    localize('some/link').must_equal '/de/some/link'
  end

  it 'localizes a relative link for missing lang' do
    @context.expect(:environments, @env_nil)
    localize('some/link').must_equal '/en/some/link'
  end

  it 'localizes the site root for given lang' do
    @context.expect(:environments, @env_de)
    localize('/').must_equal '/de/'
  end

  it 'localizes the site root for missing lang' do
    @context.expect(:environments, @env_nil)
    localize('/').must_equal '/en/'
  end

  it 'does not localize an absolute link' do
    @context.expect(:environments, @env_de)
    localize('/some/link').must_equal '/some/link'
  end

  it 'does not localize http://' do
    @context.expect(:environments, @env_de)
    localize('http://site').must_equal 'http://site'
  end

  it 'does not localize https://' do
    @context.expect(:environments, @env_de)
    localize('https://site').must_equal 'https://site'
  end
end
