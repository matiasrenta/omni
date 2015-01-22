class SessionsController < ApplicationController

  def create
    @auth_hash = env["omniauth.auth"].to_yaml
    puts env["omniauth.auth"].to_yaml


    auth = env["omniauth.auth"]
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    session[:access_token] = auth["credentials"]["token"]



    redirect_to products_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to products_url, notice: "Signed out!"
  end

end