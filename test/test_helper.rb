# frozen_string_literal: true

require 'bundler/setup'

require 'single_cov'
SingleCov.setup :minitest

require 'maxitest/autorun'
require 'maxitest/timeout'
require 'mocha/mini_test'

$LOAD_PATH.unshift 'lib'
