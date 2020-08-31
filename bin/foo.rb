#!/usr/bin/env ruby

require 'bundler/setup'
require 'pry'

$LOAD_PATH.unshift File.expand_path('.', 'lib')

require 'main'

Main.call

p '.'
