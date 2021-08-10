class LineItemsController < ApplicationController
    def create
        chosen_parking = Parking.find(params[:parking_id])
        current_cart = @current_cart
        
        if current_cart.parkings.include?(chosen_parking)

          @line_item = current_cart.line_items.find_by(:parking_id => chosen_parking)
          @line_item.quantity += 1
        else
          @line_item = LineItem.new
          @line_item.cart = current_cart
          @line_item.parking = chosen_parking
        end

        @line_item.save


        redirect_to cart_path(current_cart)
      end

      def destroy
        @line_item = LineItem.find(params[:id])
        @line_item.destroy
        redirect_to cart_path(@current_cart)
      end  

      def add_quantity
        @line_item = LineItem.find(params[:id])
        @line_item.quantity += 1
        @line_item.save
        redirect_to cart_path(@current_cart)
      end
      
      def reduce_quantity
        @line_item = LineItem.find(params[:id])
        if @line_item.quantity > 1
          @line_item.quantity -= 1
        end
        @line_item.save
        redirect_to cart_path(@current_cart)
      end
      
      private
        def line_item_params
          params.require(:line_item).permit(:quantity, :parking_id, :cart_id)
        end
end