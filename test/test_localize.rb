# frozen_string_literal: true

# test_localize.rb: Unit tests for the localize filter.

require "minitest/autorun"
require "liquid"
require "localize"

describe Jekyll::LocalizeFilter do
  include Jekyll::LocalizeFilter

  before do
    @env_de  = [{ "page" => { "lang" => "de" } }]
    @env_nil = [{ "page" => {} }]

    @context = Minitest::Mock.new
  end

  it "localizes a relative link for given lang" do
    @context.expect(:environments, @env_de)
    _(localize("some/link")).must_equal "/de/some/link"
  end

  it "localizes a relative link for missing lang" do
    @context.expect(:environments, @env_nil)
    _(localize("some/link")).must_equal "/en/some/link"
  end

  it "localizes the site root for given lang" do
    @context.expect(:environments, @env_de)
    _(localize("/")).must_equal "/de/"
  end

  it "localizes the site root for missing lang" do
    @context.expect(:environments, @env_nil)
    _(localize("/")).must_equal "/en/"
  end

  it "does not localize an absolute link" do
    @context.expect(:environments, @env_de)
    _(localize("/some/link")).must_equal "/some/link"
  end

  it "does not localize http://" do
    @context.expect(:environments, @env_de)
    _(localize("http://site")).must_equal "http://site"
  end

  it "does not localize https://" do
    @context.expect(:environments, @env_de)
    _(localize("https://site")).must_equal "https://site"
  end
end
