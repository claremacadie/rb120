# Parent.rb

class Parent
  def say_hi
    p "Hi from Parent."
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end

  def instance_of?
    "I'm a fake instance"
  end
end

# child = Child.new
# child.say_hi

# son = Child.new
# son.send :say_hi

# daughter = Child.new
# daughter.send

# girl = Child.new
# p girl.instance_of? Child
# p girl.instance_of? Parent

heir = Child.new
p heir.instance_of?
