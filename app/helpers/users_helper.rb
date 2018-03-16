module UsersHelper
   def user_cart
      current_user.current_cart if current_user
   end
end