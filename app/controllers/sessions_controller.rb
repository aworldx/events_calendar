class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: %i[new create]
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_back_or root_url
    else
      flash.now[:danger] = t('messages.invalid_credintials')
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
