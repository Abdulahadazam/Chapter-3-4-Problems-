require 'date'


class Task
    attr_accessor :id, :description, :priority, :due_date, :completed



    def initialize(id, description, priority, due_date)
        @id = id
        @description = description
        @priority = priority
        @due_date = Date.parse(due_date)
        @completed = false
    end 


    def mark_complete
        @completed = true
    end 


    def to_s
    status = completed ? "[✓]" : "[ ]"
    "#{status} ##{id}: #{description} (Priority: #{priority}, Due: #{due_date})"
    end

end 


class TaskManager
    def initialize
        @tasks = {}
    end 

    def add_task(task)
        @tasks[task.id] = task
    end 

    def remove_task(id)
        @tasks.delete(id)
    end 

    def find_task(id)
        @tasks[id]
    end 

    def list_by_priority
        sorted = @tasks.values.sort_by { |task| -task.priority}
        sorted.each{ |task| puts task}
    end 


    def tasks_due_today
        today = Date.today
        due_today = @tasks.values.select {|task| task.due_date == today}
        due_today.each { |task| puts task}
    end 

    def each_task
        @tasks.values.each do |task|
            yield task
        end
    end 

    def custom_sort(&block)
        @tasks.values.sort(&block)
    end 
end 

task_manager = TaskManager.new

task_manager.add_task(Task.new(1, "Complete Ruby assignment", 3, "2025-09-18"))
task_manager.add_task(Task.new(2, "Prepare for meeting", 5, "2025-09-17"))
task_manager.add_task(Task.new(3, "Go grocery shopping", 1, "2025-09-20"))

puts " All Tasks Sorted by Priority:"
task_manager.list_by_priority

puts "\n Tasks Due Today:"
task_manager.tasks_due_today

puts "\n Marking Task 1 as Complete using Block Iterator:"
task_manager.each_task do |task|
  task.mark_complete if task.id == 1
end

puts "\n Custom Sort by Due Date (Soonest First):"
task_manager.custom_sort { |a, b| a.due_date <=> b.due_date }
            .each { |t| puts t }
    
    
    