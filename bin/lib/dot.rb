#!/usr/bin/env dotruby

require 'bundler/inline'

gemfile do
 source 'https://rubygems.org'
 gem 'thor'
end

class Dot < Thor
  $PROGRAM_NAME = "dot"

  desc "setup", "setup all dotfiles"
  def setup()
    # Make sure to be in the dotfiles directory
    Dir.chdir ENV['DOTFILES']
    # Run Setup Script
    load File.expand_path("bin/lib/setup.rb"), true
  end

end

Dot.start(ARGV)
