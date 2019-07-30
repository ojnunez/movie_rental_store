# frozen_string_literal: true

module Users
  module Api
    class RentsController < Users::ApiV1Controller
      def return
        @rent = Rent.where(order_id: params[:order_id]).first
        if @rent.nil?
          render json: {
            error: "Order doesn't exists; check again",
            status: :bad_request
          }, status: :bad_request
        else
          @rent.return_rented_item
          render json: @rent.to_json
        end
      end
    end
  end
end
