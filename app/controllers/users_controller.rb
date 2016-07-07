class UsersController < ApplicationController

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :'/users/create_user'
  end

  post '/signup' do
    if any_nil?(params)
      @error = true
      redirect '/signup'
    else
      user = User.new
      user.username = params[:username]
      user.email = params[:email]
      user.password = params[:password]
      login(user.username, user.password)
      redirect '/tweets'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_tweet'
  end


end
