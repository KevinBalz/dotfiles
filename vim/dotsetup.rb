# TODO: Handle symlinking for neo-vim
# TODO: Skip non Vundle relatet stuff of .vimrc when PluginInstalling

after_link do
  unless File.exists?(File.join(Dir.home, ".vim/bundle/Vundle.vim"))
    system("git clone https://github.com/VundleVim/Vundle.vim.git #{Dir.home}/.vim/bundle/Vundle.vim")
  end
  system("vim +PluginInstall +qall")
end
