# frozen_string_literal: true

module Admins
  module ApiV1
    class MoviesController < Admins::ApiV1Controller
      before_action :set_item, only: %i[update destroy]

      # GET /admins/api/movies
      def index
        # Get movies that are available
        @movies = Movie.order(title: :asc)

        # Simple search if params availability comes in the url
        if params[:availability] && params[:availability] == 'true'
          @movies = @movies.where(availability: true)
        elsif params[:availability] && params[:availability] == 'false'
          @movies = @movies.where(availability: false)
        end
        render json: @movies.to_json
      end

      # POST /admins/api/movies
      def create
        @movie = Movie.new item_params
        if @movie.save
          render json: @movie.to_json,
                 status: :created
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      # PATCH /admins/api/movies/:id
      def update
        @movie.assign_attributes item_params.reject { |_, v| v.blank? }
        # In the current API we allow the admin update any fields, to do that we
        # need to remove all the blank params of the object, because we don't
        # want to trigger any validations for the fields that we didn't send
        if @movie.save
          render json: @movie.to_json
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      # DELETE /admins/api/movies/:id
      def destroy
        # Destroy the movie once and for all and return a nice 200 OK header
        @movie.destroy
        render status: 200
      end

      private

      # White list for allowed params.
      def item_params
        params.require(:movie).permit(:title, :description, :stock,
                                      :sale_price, :rent_price, :availability, :cover)
      end

      # find item
      def set_item
        @movie = Movie.find(params[:id])
      end
    end
  end
end
