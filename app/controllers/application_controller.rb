class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      flash[:alert] = "No tienes permiso para realizar esta acción."
      redirect_to(request.referrer || root_path)
    end
end
