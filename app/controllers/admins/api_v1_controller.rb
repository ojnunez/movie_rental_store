# frozen_string_literal: true

module Admins
  class ApiV1Controller < AdminsController
    # This is private property, so we must be logged if we want to do something
    # in this admin api section
    before_action :authenticate_admins_api_v1_admin!
    respond_to :json
  end
end
