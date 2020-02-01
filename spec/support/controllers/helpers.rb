module Controllers
  module Helpers
    def sign_in_user(user)
      token = Knock::AuthToken.new(payload: { sub: user.id }).token
      @request.headers["Authorization"] = "Bearer #{token}"
    end
  end
end
