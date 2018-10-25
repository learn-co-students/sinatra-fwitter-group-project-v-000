class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/twitter/index'
    else
      redirect to "/users/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'twitter/new'
    else
      redirect "/login"
    end
  end

  get '/tweets/:slug' do
    if logged_in?
      @tweet = Tweet.find_by_slug(params[:slug])
      erb :'twitter/show'
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    unless params[:content] == ""
      @tweet = Tweet.create(params)

      redirect '/tweets'
    end
    redirect "/tweets/new"
  end

end
