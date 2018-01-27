class TweetsController < ApplicationController
	get '/tweets' do
		@tweets = Tweet.all
		erb :'tweets/tweets'
	end

	get '/tweets/new' do
		erb :'tweets/create_tweet'
	end

	post 'tweets' do
		@tweet = Tweet.new(content: params[:content])
		erb :'tweets/show_tweet'
	end

	get '/tweets/:slug' do
    	@tweet = Tweet.find_by_slug(params[:slug])
    erb :'tweets/tweets/show'
  end

  get '/tweets/:slug/edit' do
  	if logged_in?
	    @tweet = Tweet.find_by_slug(params[:slug])
	    erb :'tweets/tweets/edit'
	else
		redirect to '/login'
	end
  end
end
