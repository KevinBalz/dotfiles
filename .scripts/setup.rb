
class Dotsetup
  attr_accessor :before_func
  attr_accessor :after_func

  def initialize
    @before_func = nil
    @after_func = nil
  end

  def before_link(&func)
    @before_func = func
  end

  def after_link(&func)
    @after_func = func
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
    puts "Evaluating: #{dotsetup}"
    dots = Dotsetup.load(dotsetup)
  end
  dots&.before_func&.call
  puts "stowing ..."
  system("stow -Rv --ignore='^dotsetup.rb' #{dir}")
  dots&.after_func&.call
end


Dir.foreach(Dir.pwd) do |item|
  next if item.start_with?('.')
  next if File.file?(item)

  puts "Setting up: #{item}"
  setup_dir(item)
end
