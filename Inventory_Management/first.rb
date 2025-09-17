class Product 
    attr_accessor :id, :name, :price, :quantity


    def initialize(id,name, price, quantity)
        @id = id
        @name = name
        @price =  price
        @quantity =  quantity 
    end 


    def to_s
        "#{name} (ID:#{id} - #{price}, Quantity: #{quantity})"
    end
end 



class Inventory
    def initialize
        @products = {}
    end 


    def add_product(product)
        @products[product.id] =  product
    end 


    def update_stock(id, new_quantity)
        @products[id].quantity = new_quantity if @products.key?(id)
    end 

    def low_stock(threshold)
        @products.values.select{ |p| p.quantity < threshold}
    end 

    def most_expensive
    @products.values.max_by(&:price)
    end

    def display
        @products.each_value { |p| puts p}
    end 

end 


inventory = Inventory.new
inventory.add_product(Product.new(1, "Laptop", 1000, 5))
inventory.add_product(Product.new(2, "Mouse", 20, 50))
inventory.update_stock(2, 10)
puts "Low stock products: "
puts inventory.low_stock(15)
puts "Most expensive: #{inventory.most_expensive}"




