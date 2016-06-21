class UsersController < ApplicationController

  get '/signup' do

    if logged_in?
      redirect '/tweets'
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    user = User.new(params)

    if user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all
    erb :user_tweets
  end

end