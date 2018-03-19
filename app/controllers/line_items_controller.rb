class LineItemsController < ApplicationController
    def create
        if cart = current_user.current_cart
            cart.add_item(params[:item_id])
        else
            cart = current_user.carts.create
            cart.add_item(params[:item_id])
        end
        cart.save
        redirect_to cart_path(cart)
    end
end
