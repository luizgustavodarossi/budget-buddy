class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :template_for_devise, if: :devise_controller?

  private

  def template_for_devise
    devise_controller? ? 'devise' : 'application'
  end
end
