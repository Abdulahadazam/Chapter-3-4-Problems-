class Employee
  attr_accessor :id, :name, :salary
  def initialize(id, name, salary)
    @id, @name, @salary = id, name, salary
  end
end

employees = [
  Employee.new(1, "John", 3000),
  Employee.new(2, "Jane", 5000),
  Employee.new(3, "Alice", 7000)
]

total_salary = employees.map(&:salary).reduce(:+)
high_earners = employees.select { |e| e.salary > 4000 }
employees.each { |e| e.salary *= 1.10 }

puts "Total salary: #{total_salary}"
puts "High earners: #{high_earners.map(&:name)}"
