# frozen_string_literal: true

module Users
  module ApiV1
    class OrdersController < Users::ApiV1Controller
      # POST /users/api/orders/buy
      def create
        @order = Order.new item_params
        # The user that made the request is the user that buy the product
        @order.user = current_users_api_user
        if @order.save
          render json: @order.to_json,
                 status: :created
        else
          render json: @order.errors,
                 status: :unprocessable_entity
        end
      end

      private

      # White list
      def item_params
        params.require(:order).permit(:movie_id, :quantity, :sale_kind)
      end
    end
  end
end
