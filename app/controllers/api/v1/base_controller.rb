module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user
      include Pundit
    end
  end
end
