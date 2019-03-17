class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.find_or_create_by(:content => params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
      binding.pry
      user = User.find(session[:user_id])
      redirect to "/tweets/#{user.slug}"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:slug' do

    # redirect to "/tweets/show_tweet"
  end

end
