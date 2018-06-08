class TweetController < ApplicationController

  get '/tweets' do
    if is_logged_in?
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

  post '/tweets' do
    if !is_logged_in?
      redirect '/user/login'
    end
    if !!@user = User.find_by(email: params[:email])
      redirect '/user/login'
    end
    @tweet = Tweet.create(content: params[:content])
    erb :'/tweets/show'
  end
end
