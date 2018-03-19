class StoreController < ApplicationController
    def index
        @categories = Category.all
        @items = Item.all
        @user = User.new
    end
    
end
