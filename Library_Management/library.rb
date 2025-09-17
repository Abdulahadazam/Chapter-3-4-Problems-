
class Book
        attr_accessor :title, :author, :available

  def initialize(title, author)
    @title, @author, @available = title, author, true
  end
end

class Library
  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def rent_book(title)
    book = @books.find { |b| b.title == title && b.available }
    book.available = false if book
    book
  end

  def return_book(title)
    book = @books.find { |b| b.title == title }
    book.available = true if book
  end

  def filter_books(&block)
    @books.select(&block)
  end
end

library = Library.new
library.add_book(Book.new("1984", "George Orwell"))
library.add_book(Book.new("Animal Farm", "George Orwell"))
puts library.filter_books { |b| b.author == "George Orwell" }.map(&:title)