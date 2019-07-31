# frozen_string_literal: true

module Users
  module ApiV1
    class MoviesController < Users::ApiV1Controller
      # Our index action is public, authenticated and guest users can see our
      # movie list and the detail
      skip_before_action :authenticate_users_api_v1_user!, only: %i[index show]

      # GET /users/api/movies
      def index
        # Get movies that are available
        @movies = Movie.are_available.order(title: :asc)

        # If sort_by_likes is present we sort by likes and title
        @movies = if params[:sort_by_likes].present?
                    @movies.order(likes_counter: :desc, title: :asc)
                  else
                    @movies.order(title: :asc)
                  end
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

      def show
        @movie = Movie.find(params[:id])

        if @movie && @movie.availability == true
          render json: @movie.to_json(json_options)
        else
          render json: { status: :unprocessable_entity } 
        end
      end

      # GET /users/api/movies/:id/like
      def like
        # A thumbs up button just like any other social media site
        # We click on the like button and fires a petition and check if we
        # like the item (object), or we 'unlike' it.
        @like = MovieLike.where(movie_id: params[:id],
                                user_id: current_users_api_v1_user.id).first_or_initialize
        if @like.new_record?
          if @like.save
            render json: { 'success' => true, 'action' => 'like' },
                   status: :created
          else
            # If the movie doesn't exists, we show an error
            render json: { 'success' => false, 'errors' => @like.errors },
                   status: :unprocessable_entity
          end
        else
          # Unlike (maybe was a mistake by the user), so we remove that like.
          @like.destroy
          render json: { 'success' => true, action: 'dislike' },
                 status: :ok
        end
      end

      # We define this method if we want to show certain attributes or method
      # to the users
      def json_options
        {
          methods: [:cover_image_url]
        }
      end
    end
  end
end
