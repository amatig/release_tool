#!/usr/bin/env ruby

require "bundler/setup"
require "thor"

# Subcommands
require_relative "sub_commands/release"

class CLI < Thor
  desc "release", "Release commands"
  subcommand "release", ReleaseSubcommand
end

# Start the CLI
CLI.start(ARGV)
