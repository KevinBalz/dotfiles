require 'autogem'
require_gem 'paint'

module Setup

  class << self
    attr_accessor :interactive
  end
  self.interactive = true

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


  def Setup.setup_dir(dir)
    dotsetup = File.join(dir,'dotsetup.rb')
    dots = nil
    if File.exists?(dotsetup)
      puts "#{Paint["Evaluating:", :cyan]} #{Paint[dotsetup, :yellow]}"
      dots = Dotsetup.load(dotsetup)
    end
    dots&.before_func&.call
    if dots == nil or dots.link
      link_dir(dir)
    else
      puts "skip linking"
    end
    dots&.after_func&.call
  end

  def Setup.link_dir(dir,target_dir=Dir.home)
    Dir.foreach(dir) do |file|
      next if File.directory?(file)
      next if file == "dotsetup.rb"

      full_file = File.expand_path(File.join(dir,file))
      link_target = File.join(target_dir, file)

      link_file(full_file,link_target)
    end
  end

  def Setup.link_file(file,target)
    if not File.exist?(target) and not File.symlink?(target)
      File.symlink(file,target)
      puts "#{Paint[file, :cyan]} => #{Paint[ target, :yellow]} linked"
    elsif File.symlink?(target)
      linkt = File.readlink(target)
      if linkt == file then
        puts "#{Paint[file, :cyan]} => #{Paint[ target, :yellow]} already linked"
      else
        puts "There is already a symlink '#{target}' pointing to '#{linkt}'"
        print "Do you want to remove the old link? (y/n): "
        if !self.interactive or "y" == STDIN.gets.chomp.downcase
          File.delete(target)
          link_file(file,target)
        else
          raise "Old symlink blocking"
        end
      end
    else
      puts "#{Paint["File #{target} already exists!", :red]}"
      new_name = target + ".old"
      loop do
        if !self.interactive
          option = "r"
        else
          print "(O)verwrite, (S)how the file, (R)ename the file to '#{new_name}': "
          option = STDIN.gets.chomp.downcase
        end
        case option
        when "o"
          print "Are you sure? This will delete the file (y/n): "
          if "y" == STDIN.gets.chomp.downcase
            File.delete(target)
            link_file(file,target)
            break
          end
        when "s"
          puts File.new(target, "r").gets
        when "r"
          File.rename(target,new_name)
          puts "renamed #{target} to #{new_name}"
          link_file(file,target)
          break
        end
      end
    end
  end

  def Setup.run()
    Dir.foreach(Dir.pwd) do |item|
      next if item.start_with?('.')
      next if File.file?(item)

      puts "#{Paint["Setting up:", :blue]} #{Paint[item, :yellow]}"
      Setup::setup_dir(item)
    end
  end

end

