require 'yaml'
class RoadWarriorNamer
  def name_me
    name = ''
    
    base = get_word
    if rand > 1.0 / 3
      word = get_word
      base += word unless base =~ Regexp.new(word)
    end
    base.capitalize!
    name = base
    
    if rand > 2.0 / 3
      prefix = get_prefix.capitalize
      name = prefix + ' ' + name
    end
    
    if rand > 3.0 / 4
      second = ''
      word = get_word
      second += word unless name =~ Regexp.new(word)
      if rand > 2.0 / 3
        word = get_word
        second += word unless name =~ Regexp.new(word)
      end
      name += (" " + second.capitalize) unless second.empty?
    end
    
    if rand > 3.0 / 4
      suffix = get_suffix
      if suffix [0] == ','
        name = name + suffix
      else
        name = name + ' ' + suffix
      end
    end
    
    name
  end
  
  def get_word
    names.sample.strip.downcase
  end
  
  def get_prefix
    prefixes.sample.strip
  end
  
  def get_suffix
    suffixes.sample.strip
  end

  def names
    @names ||= YAML.load_file File.expand_path('config/names.yml')
  end

  def prefixes
    @prefixes ||= YAML.load_file File.expand_path('config/prefixes.yml')
  end
  
  def suffixes
    @suffixes ||= YAML.load_file File.expand_path('config/suffixes.yml')
  end
end

puts RoadWarriorNamer.new.name_me
