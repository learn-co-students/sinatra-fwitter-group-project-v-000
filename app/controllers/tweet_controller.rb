class TweetController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      # @tweets = current_user.tweets
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/errors/login' do
    erb :'/errors/login'
  end

  get '/errors/signup' do
    erb :'/errors/signup'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/show' do
    if is_logged_in?
      binding.pry
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    # binding.pry
    if params[:content] == ""
      redirect '/tweets/new'
    end
    if !is_logged_in?
      redirect '/user/login'
    end
    if !!@user = User.find_by(email: params[:email])
      redirect '/user/login'
    end
    @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
    erb :'/tweets/show'
  end
end
