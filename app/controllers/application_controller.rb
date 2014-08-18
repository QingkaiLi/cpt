class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    begin
      @current_user = User.find(session[:user_id]) if session[:user_id]
    rescue Exception => e
      @current_user = nil
      # log
    end
  end
  helper_method :current_user

  def authorize
    msg = 'Please log in to continue.';
    if session['error_msg'] != nil
      msg = session['error_msg']
      session['error_msg'] = nil
    end

    if current_user.nil?
      session[:return_to] = request.url if request.get?
      redirect_to login_url, alert: msg
    end
  end
end

WillPaginate.per_page = 3