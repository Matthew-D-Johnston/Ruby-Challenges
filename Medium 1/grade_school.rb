# grade_school.rb

class School
  def initialize
    @students = {}
  end

  def to_h
    @students.sort.to_h
  end

  def add(name, grade)
    @students[grade] ? @students[grade] << name : @students[grade] = [name]
    @students[grade].sort!
  end

  def grade(grd)
    @students[grd] || []
  end
end
