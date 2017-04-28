class TweetController < ApplicationController
	get '/tweets' do
    # binding.pry
    if session[:id]
      @user = current_user
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end

  get '/tweets/:slug' do
    @tweet = Tweet.find_by_slug(params[:slug])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
  end

  post '/tweets/:id' do
  	#update to tweets/id
  end

  post '/tweets/:id/delete' do
  	#deletion of tweet 
  end
end