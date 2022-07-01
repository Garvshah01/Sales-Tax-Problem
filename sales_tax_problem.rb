class SalesTax
    @@item_list = []
    @@total_amount = 0
    SALES_TAX = 10/100.0
    IMPORT_TAX = 5/100.0
    attr_accessor :name, :imported, :exemption, :price
    def initialize
        yield self
    end
    def add_item(tax)
        @@item_list += [[@name.chop,tax,@price]]
        @@total_amount += @price
    end
    def tax_calculation
        @price = @price.to_f
        tax = 0
        # p @imported
        # p @exemption
        tax += import_tax if(@imported.chop == 'yes')
        tax += sales_tax if(@exemption.chop == 'no')
        @price += tax
        add_item(tax)
    end
    def import_tax
        # p @price*(SALES_TAX)
        @price*(SALES_TAX)
    end
    def sales_tax
        # p @price*(IMPORT_TAX)
        @price*(IMPORT_TAX)
    end
    def self.display
        puts "__________________________________________________________________________________________________"
        puts ""
        puts "      Item_Name                 Tax                       Price"
        
        @@item_list.each_with_index do |item, index|
            print "#{(index+1).to_s.ljust(5)} #{item[0].ljust(25)} #{item[1].to_s.ljust(25)} #{item[2].to_s.ljust(25)}\n"
        end
        puts "___________________________________________________________________________________________________"
        puts ""
        puts "Total Amount - #{@@total_amount.round(0)}".rjust(61)
        puts "\n"
    end
end


input = 'y'
while(input == 'y')
    obj1 = SalesTax.new do |element|
        print 'Name of the product: '
        element.name = gets
        print 'Imported?: '
        element.imported = gets
        print 'Exempted from sales tax? '
        element.exemption = gets
        print 'Price: '
        element.price = gets
    end
    obj1.tax_calculation
    print 'Do you want to add more items to your list(y/n): '
    input = gets
    input = input.chop
end
print SalesTax.display

