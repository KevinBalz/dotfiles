
def require_gem(gemname,requirename=gemname)
  begin
    gem gemname
  rescue Gem::LoadError
    Gem.install(gemname)
    gem gemname
  end
  require requirename
end

