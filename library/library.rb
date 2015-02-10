class Library
  attr_accessor :shelves
  def initialize
    @shelves = []
  end

  def shelf_count
    return @shelves.length
  end

  def list_all_books
    @shelves.each do |shelf|
      puts "#{shelf.name}"
      puts "----------"

      shelf.list_books

      puts "----------\n\n"
    end
  end
end

class Shelf
  attr_accessor :books, :name
  def initialize(name, library)
    @books = []
    @name = name
    library.shelves << self
  end

  def list_books
    @books.each do |book|
      puts book.to_s
    end
  end
end

class Book
  attr_reader :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end

  def enshelf(shelf)
    shelf.books << self
  end

  def unshelf(shelf)
    shelf.books.delete(self) { puts "#{self.title} is not on this shelf." }
  end

  def to_s
    "\"#{@title}\", by #{@author}"
  end
end

# Create the library
spl = Library.new

# Create several shelves
programming = Shelf.new("Programming", spl)
ruby = Shelf.new("Ruby", spl)
business = Shelf.new("Business", spl)
cyber_security = Shelf.new("Cyber Security", spl)

# Create several books
eloquent_ruby     = Book.new("Eloquent Ruby", "Russ Olsen")
linchpin          = Book.new("Linchpin", "Seth Godin")
digital_forensics = Book.new("Real Digital Forensics", "Richard Bejtlich")

# Put all the books on their initial shelves
eloquent_ruby.enshelf(programming)
linchpin.enshelf(business)
digital_forensics.enshelf(cyber_security)

# List all the books and the library's shelf count
puts "Library contains #{spl.shelf_count} shelves."
spl.list_all_books

# Move "Eloquent Ruby" from the "Programming" shelf to the "Ruby" shelf
puts "Moving #{eloquent_ruby.to_s}..."
eloquent_ruby.unshelf(programming)
eloquent_ruby.enshelf(ruby)

spl.list_all_books
