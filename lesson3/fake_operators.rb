# fake_operators.rb

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

# bob = Person.new("Bob", 49)
# kim = Person.new("Kim", 33)

# puts "bob is older" if bob > kim            # => "bob is older"
# puts "bob is older" if bob.>(kim)           # => "bob is older"

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end

# cowboys = Team.new("Dallas Cowboys")
# emmitt = Person.new("Emmitt Smitt", 46)
# cowboys << emmitt
# p cowboys.members

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

# dream_team = cowboys + niners
# dream_team.name = "Dream Team"
# puts dream_team.inspect

p cowboys.members

p cowboys[1]
cowboys[3] = Person.new("JJ", 72)
p cowboys[3]

