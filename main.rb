#!/usr/bin/env ruby

require 'bundler/setup'
require "open4"

pid, stdin, stdout, stderr = Open4::popen4 "git log" 

puts stdout.read.strip