
before_link do
  unless File.exists?(File.join(Dir.home, ".slimzsh"))
    system("git clone --recursive https://github.com/changs/slimzsh.git #{Dir.home}/.slimzsh")
  end
end
