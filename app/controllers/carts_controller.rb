class CartsController < ApplicationController
    before_action :find_cart

    def show
        @cart = Cart.find(params[:id])
    end
    
    def checkout
        @cart.checkout
        current_user.current_cart = nil
        redirect_to cart_path(@cart)
    end
    
    private
    
    def find_cart
       @cart = Cart.find_by(id: params[:id]) 
    end

end
