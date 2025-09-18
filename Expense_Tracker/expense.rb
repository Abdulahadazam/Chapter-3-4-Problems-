require 'date'


module Formatter
  def format_currency(amount)
    "$#{'%.2f' % amount}"
  end

  def format_date(date)
    date.strftime("%d-%b-%Y")
  end
end

class Expense
  attr_reader :id, :category, :amount, :date, :note

  def initialize(id, category, amount, date, note)
    @id = id
    @category = category
    @amount = amount
    @date = Date.parse(date)
    @note = note
  end

  def to_s
    "##{id} [#{category}] - #{amount} on #{date} (#{note})"
  end
end

class ExpenseManager
  include Formatter

  def initialize
    @expenses = {}
    @next_id = 1
  end

  def add_expense(category, amount, date, note)
    expense = Expense.new(@next_id, category, amount, date, note)
    @expenses[@next_id] = expense
    @next_id += 1
    puts "Expense added: #{expense}"
  end

  def remove_expense(id)
    if @expenses.delete(id)
      puts "Expense ##{id} removed."
    else
      puts "Expense not found."
    end
  end

  def list_all_expenses
    if @expenses.empty?
      puts "No expenses found."
    else
      @expenses.values.each { |e| puts e }
    end
  end

  def list_by_category(category)
    filtered = @expenses.values.select { |e| e.category.downcase == category.downcase }
    if filtered.empty?
      puts "No expenses in category '#{category}'."
    else
      filtered.each { |e| puts e }
    end
  end

  def total_expense
    total = @expenses.values.map(&:amount).reduce(0, :+)
    puts "Total Expense: #{format_currency(total)}"
  end

  def highest_expense
    max = @expenses.values.max_by(&:amount)
    if max
      puts "Highest Expense: #{max}"
    else
      puts "No expenses found."
    end
  end
end


manager = ExpenseManager.new

loop do
  puts "\n--- Expense Tracker Menu ---"
  puts "1. Add Expense"
  puts "2. Remove Expense"
  puts "3. List All Expenses"
  puts "4. Show Total Expense"
  puts "5. Show Highest Expense"
  puts "6. List by Category"
  puts "7. Exit"
  print "Choose an option: "
  
  choice = gets.to_i

  case choice
  when 1
    print "Enter category: "
    category = gets.chomp
    print "Enter amount: "
    amount = gets.to_f
    print "Enter date (YYYY-MM-DD): "
    date = gets.chomp
    print "Enter note: "
    note = gets.chomp
    manager.add_expense(category, amount, date, note)

  when 2
    print "Enter expense ID to remove: "
    id = gets.to_i
    manager.remove_expense(id)

  when 3
    manager.list_all_expenses

  when 4
    manager.total_expense

  when 5
    manager.highest_expense

  when 6
    print "Enter category: "
    category = gets.chomp
    manager.list_by_category(category)

  when 7
    puts "Exiting... Goodbye!"
    break

  else
    puts "Invalid option, try again."
  end
end
