# Rakefile

require 'bundler/setup'
require_relative 'tasks/release'

namespace :release do

  desc "Show the list of releases"
  task :list do
    release = Release.new

    path = ARGV[1] || '.'
    release.list path
  end

end