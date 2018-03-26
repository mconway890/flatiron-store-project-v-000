class Cart < ActiveRecord::Base
    belongs_to :user
    has_many :line_items
    has_many :items, through: :line_items
    
    def total
        line_items.collect{|i| i.item.price * i.quantity}.inject(:+)
    end
    
    def add_item(item_id)
        if line_item = self.line_items.find_by(:item_id => item_id)
           line_item.update(:quantity => (line_item.quantity + 1))
        else
            line_item = self.line_items.build(:item_id => item_id, :cart_id => self.id)
        end
        line_item
    end
    
    def init_checkout
        line_items.each do |line_item|
            update_item(line_item)
        end
        update(status: "submitted")
        user.remove_cart
    end

    def update_item(line_item)
        item = Item.find(line_item.item_id)
        item.inventory -= line_item.quantity
        item.save
    end
end
