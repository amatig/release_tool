#!/usr/bin/env ruby

require 'bundler/setup'

require_relative 'shell'

shell = Shell.new
shell.execute 'git log'