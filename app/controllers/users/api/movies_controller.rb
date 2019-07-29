# frozen_string_literal: true

module Users
  module Api
    class MoviesController < Users::ApiController
      # Our index action is public, authenticated and guest users can see our
      # movie list and the detail
      skip_before_action :authenticate_users_api_user!, only: %i[index show]

      # GET /users/api/movies
      def index
        # Get movies that are available
        @movies = Movie.are_available.order(name: :asc)

        # Search with the help of pg_search gem
        @movies = @movies.search(params[:q]) unless params[:q].blank?
        # Add paginate to the query, by default its gonna be 10 results
        page = params[:page].to_i <= 0 ? 1 : params[:page].to_i
        @movies = @movies.paginate(page: page, per_page: 10)

        # We add pagination to the results
        response.headers['pagination'] = {
          total_pages: @movies.total_pages,
          current_page: @movies.current_page.to_i
        }.to_json
        render json: @movies.to_json(json_options)
      end
    end
  end
end
