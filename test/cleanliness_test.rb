# frozen_string_literal: true

require_relative 'test_helper'

SingleCov.not_covered!

describe 'cleanliness' do
  it 'has coverage for all tests' do
    SingleCov.assert_used
  end

  it 'has tests for all files' do
    # lib/bcp47_spec/parser.rb Coverted by bcp47_spect_test.rb
    SingleCov.assert_tested untested: %w[
      lib/bcp47_spec/parser.rb
      lib/bcp47_spec/version.rb
    ]
  end

  it 'uses frozen strings for everything' do
    bad = Dir['{lib,spec}/**/*.rb'].map do |f|
      unless File.read(f).include?('# frozen_string_literal: true')
        "#{f} needs `# frozen_string_literal: true`"
      end
    end.compact

    bad.join("\n").must_equal ''
  end
end
