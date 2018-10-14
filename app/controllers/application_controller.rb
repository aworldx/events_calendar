class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :logged_in_user
  before_action :set_locale

  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t('messages.please_log_in')
    redirect_to login_url
  end

  def set_locale
    locale = if session[:locale]
               session[:locale]
             else
               http_accept_language.compatible_language_from(I18n.available_locales)
             end
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end
end
