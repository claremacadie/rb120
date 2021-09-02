# Student.rb

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(opponent)
    grade < opponent.grade
  end

  protected
  attr_reader :grade
end

student1 = Student.new("Felix", "A")
student2 = Student.new("Henrietta", "B")
puts "Well done!" if student1.better_grade_than?(student2)
