class Cart < ActiveRecord::Base
    belongs_to :user
    has_many :line_items
    has_many :items, through: :line_items
    
    def total
        items.map(&:price).sum
    end
    
    def add_item(itemid)
        line_item = line_items.find_by(item_id: itemid)
        if items.include?(line_item.try(:item))
            line_item.update(quantity: (line_item.quantity + 1))
            line_item
        else
            line_items.new(item_id: itemid)
        end
    end

    
    def checkout
        update(status:"submitted")
        line_items.each do |i|
            item = Item.find(i.item_id)
            item.update(inventory: item.inventory - i.quantity)
        end
    end    
end
