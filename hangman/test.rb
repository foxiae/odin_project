require 'yaml'

class Sample

  def initialize(word)
    @word = word
  end

  attr_accessor :word

  def do_something
    puts "something!"
  end

  def save
    Dir.mkdir("saves") unless Dir.exist? "saves"
    filename = "saves/saved.yaml"
    File.open(filename, "w") do |file|
      file.puts YAML.dump(self)
    end
  end

end

def load
    content = File.open("saves/saved.yaml", "r") {|file| file.read}
    YAML.load(content)
end

s = Sample.new("poof")

puts "calling directly from class:"
puts s.word
puts s.do_something
puts "s.inspect returns: #{s.inspect}"

puts "saving class as yaml, with the name x"
x = s.save

puts "x.inspect returns:  #{x.inspect}"

#puts "x.s returns:  #{x.s}" =>this will throw an error

puts "Loading yaml file and assigning it to variable named q"
q = load

puts "q.inspect returns: #{q.inspect} the same type of object but with a different memory address"
puts "q.word returns: #{q.word}"
print "q.do_something returns: "
q.do_something
