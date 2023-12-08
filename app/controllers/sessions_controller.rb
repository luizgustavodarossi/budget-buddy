module Users
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for
      new_user_session_path
    end
  end
end
