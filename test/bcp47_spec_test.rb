# frozen_string_literal: true

require_relative 'test_helper'
require 'bcp47_spec'

SingleCov.covered!

describe BCP47 do
  it 'validates language tag' do
    assert BCP47.valid?('de-Latn-DE-1996-x-private-test')
    refute BCP47.valid?('cantbethislong')
  end

  it 'parses language tag' do
    tag = BCP47.parse('de-Latn-DE-1996-u-attr-co-phonebk-t-und-cyrl-x-private-test')

    assert_equal 'de', tag.language
    assert_equal 'Latn', tag.script
    assert_equal 'DE', tag.region
    assert_equal %w[1996], tag.variants
    assert_equal [%w[t und-cyrl], %w[u attr-co-phonebk]], tag.extensions
    assert_equal %w[private test], tag.private
  end

  it 'parses multiple variants' do
    tag = BCP47.parse('sl-Latn-IT-rozaj-nedis-1996')

    assert_equal 'sl', tag.language
    assert_equal 'Latn', tag.script
    assert_equal 'IT', tag.region
    assert_equal %w[1996 nedis rozaj], tag.variants
    assert_equal [], tag.extensions
    assert_equal [], tag.private
  end

  # https://tools.ietf.org/html/rfc6497#section-2.1 suggests empty extensions, but  BCP-47 does not seem to allow it
  it 'does not accept empty extensions' do
    refute BCP47.valid?('ja-t-i-ami')
  end

  it 'raises if parsing invalid language tag' do
    assert_raises(BCP47::InvalidLanguageTag) { BCP47.parse('cantbethislong') }
  end
end
