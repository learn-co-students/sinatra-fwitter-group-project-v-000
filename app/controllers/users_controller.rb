class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect to :"/tweets/index"
    else erb :"/users/signup"
    end
  end
  
  post '/signup' do
    if params[:username].present? && params[:email].present? && params[:password].present?
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:id] = @user.id
      redirect to :"/tweets/index"
    else redirect to :"/signup"
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug
    erb :"/users/show"
  end

end
