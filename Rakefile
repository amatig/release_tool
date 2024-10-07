# Rakefile

require "bundler/setup"
require_relative "tasks/release"

namespace :release do
  desc "Show the list of releases"
  task :list, [:path] do |t, args|
    args.with_defaults(path: ".")

    release = Release.new
    release.list args[:path]
  end
end
