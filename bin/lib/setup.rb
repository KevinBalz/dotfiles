require_relative 'autogem'

require_gem 'paint'

class Dotsetup
  attr_accessor :before_func
  attr_accessor :after_func
  attr_reader :link

  def initialize
    @before_func = nil
    @after_func = nil
    @link = true
  end

  def before_link(&func)
    @before_func = func
  end

  def after_link(&func)
    @after_func = func
  end

  def link_files link
    @link = link
  end

  def self.load(filename)
    dsl = new
    dsl.instance_eval(File.read(filename))
    return dsl
  end

end


def setup_dir(dir)
  dotsetup = File.join(dir,'dotsetup.rb')
  dots = nil
  if File.exists?(dotsetup)
    puts "#{Paint["Evaluating:", :cyan]} #{Paint[dotsetup, :yellow]}"
    dots = Dotsetup.load(dotsetup)
  end
  dots&.before_func&.call
  if dots == nil or dots.link
    puts "stowing ..."
    system("stow -Rv --ignore='^dotsetup.rb' #{dir}")
  else
    puts "skip linking"
  end
  dots&.after_func&.call
end

Dir.foreach(Dir.pwd) do |item|
  next if item.start_with?('.')
  next if File.file?(item)

  puts "#{Paint["Setting up:", :blue]} #{Paint[item, :yellow]}"
  setup_dir(item)
end
