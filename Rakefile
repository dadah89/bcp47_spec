# frozen_string_literal: true

require 'bundler/setup'
require 'bump/tasks'
Bundler::GemHelper.install_tasks

desc 'Run tests'
task :test do
  sh 'mtest test'
end

base_rubocop = 'rubocop --display-cop-names --display-style-guide'

desc 'Run rubocop'
task :rubocop do
  sh base_rubocop
end

namespace :rubocop do
  desc 'run rubocop on the files changed compared to master'
  task :changed do
    # --diff-filter=d: exclude deleted files
    sh "git diff --name-only --diff-filter=d --relative master...HEAD | xargs #{base_rubocop}"
  end
end
