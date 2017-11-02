class TweetsController < ApplicationController

	get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
    erb :'tweets/index'
      else redirect to "/login"
    end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'tweets/new'
  	else redirect to "/login"
  	end
  end

  post '/tweets' do 
    if logged_in?
      @tweet = tweet.content(:content => params["content"])
      @tweet.user = User.find_by_id(params[:id])
      @tweet.save
      flash[:message] = "Tweety Tweet Tweet."
      redirect to "/users/:slug"
    else
      redirect to "/login"
    end
  end



end
