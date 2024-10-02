#!/usr/bin/env ruby

require 'bundler/setup'

require_relative 'core/shell'

shell = Shell.new

begin
	puts shell.execute 'ls -l'
rescue => error
	puts "Error:"
	puts error
end