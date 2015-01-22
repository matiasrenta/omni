class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  rescue_from OAuth2::Error do |exception|
    if exception.response.status == 401
      session[:user_id] = nil
      session[:access_token] = nil
      redirect_to root_url, alert: "Access token expired, try signing in again."
    end
  end

  private

  def oauth_client
    @oauth_client ||= OAuth2::Client.new("64d57d11ccc60cb69cf1493fe1e05789fb33e46e2551aae72c3b52e27ac30fe1", "1317cb7298cf919623bbce3dba1fe4875d7dd1d3296632db6084952949b6ece8", site: "http://localhost:3001")
  end

  def access_token
    if session[:access_token]
      @access_token ||= OAuth2::AccessToken.new(oauth_client, session[:access_token])
    end
  end




  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
