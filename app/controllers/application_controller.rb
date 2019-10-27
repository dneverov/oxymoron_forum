class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!, only: [:create, :update, :destroy, :new, :edit]

  # Выключаем лейаут для всех ajax-запросов
  layout proc {
    if request.xhr?
      false
    else
      set_gon
      "application"
    end
  }

  protected
    def verify_captcha response
      result = RestClient.post(
                  "https://www.google.com/recaptcha/api/siteverify",
                  secret: Rails.application.secrets[:recaptcha]["secret_key"],
                  response: response)

      JSON.parse(result)["success"]
    end

  private
    def set_gon
      gon.current_user = current_user.public_fields if current_user
    end
    
    def authenticate_user!
      unless current_user
        if request.xhr?
          render json: {msg: "Вы не авторизованы"}, status: 403            
        else
          redirect_to root_path
        end
      end
    end

    def user_not_authorized
      if request.xhr?
        render json: {msg: "Нет прав на данное действие"}, status: 403            
      else
        redirect_to root_path
      end
    end
end
