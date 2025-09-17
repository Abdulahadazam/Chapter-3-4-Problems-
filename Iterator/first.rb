class Employee
    attr_accessor :name

    def create_employee(name)
        @name = name
    end 


    Employee.new("AbdulAhad")
    Employee.new("Awais Saeed")
    