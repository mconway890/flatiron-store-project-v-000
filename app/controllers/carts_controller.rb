class CartsController < ApplicationController

    def show
        @user = User.find_by(params[:id])
        @current_cart = @user.current_cart
    end
    
    def checkout
        checkout_cart = current_cart
        current_cart.init_checkout
        redirect_to cart_path(checkout_cart)
    end

end
