#!/usr/bin/env ruby

require "bundler/setup"
require "thor"

# Subcommands
require_relative "sub_commands/release"

class CLI < Thor
  class_option :dir, default: ".", desc: "Git repo directory"

  desc "release", "Release commands"
  subcommand "release", ReleaseSubcommand
end

# Start the CLI
CLI.start(ARGV)
