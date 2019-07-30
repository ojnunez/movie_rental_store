# frozen_string_literal: true

module Users
  class ApiV1Controller < UsersController
    # We will only require a logged user if they need to rent or buy a movie,
    # otherwise, anybody can see the movie list and its details
    before_action :authenticate_users_api_v1_user!
    respond_to :json
  end
end
