class TweetsController < ApplicationController
	get '/tweets' do
		@tweets = Tweet.all
		erb :'tweets/tweets'
	end

	get '/tweets/new' do
		if logged_in?
		erb :'tweets/create_tweet'
		else
		redirect to '/login'
	end
	end

	post '/tweets' do
		@tweet = Tweet.new(content: params[:content])
		redirect to "/tweets/#{@tweet.id}"
	end

	get '/tweets/:id' do
		if logged_in?
    	@tweet = Tweet.find_by(params[:id])
    	else
		redirect to '/login'
    	end
    erb :'tweets/show_tweet'

  end

  get '/tweets/:id/edit' do
  	if logged_in?
	    @tweet = Tweet.find_by(params[:id])
	    erb :'tweets/edit'
	else
		redirect to '/login'
	end
  end
end
