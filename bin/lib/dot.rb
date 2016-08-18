
case ARGV[0]
when "setup"
  # Make sure to be in the dotfiles directory
  Dir.chdir ENV['DOTFILES']
  # Run Setup Script
  load File.expand_path("bin/lib/setup.rb"), true
when "ruby"
  system "#{Gem.ruby}", *ARGV.drop(1)
end
