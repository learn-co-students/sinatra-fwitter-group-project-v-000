class UsersController < ApplicationController

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :'users/new'
  end

  post '/signup' do
    if valid_signup?(params)
      @user = User.create(params)
      # session[:user_id] = @user.id
      login(params)
      redirect '/tweets'
    else
      invalid_signup_routing(params)
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
