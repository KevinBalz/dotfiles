require_relative 'autogem'

require_gem 'thor'
class Dot < Thor
  $PROGRAM_NAME = "dot"

  desc "setup", "setup all dotfiles"
  def setup()
    # Make sure to be in the dotfiles directory
    Dir.chdir ENV['DOTFILES']
    # Run Setup Script
    load File.expand_path("bin/lib/setup.rb"), true
  end

  desc "ruby ARGUMENTS", "runs the dot bundled ruby"
  def ruby(*args)
     exec "#{Gem.ruby}", *args
  end
end

Dot.start(ARGV)
