class TweetsController < ApplicationController

	get '/tweets' do
		@tweets = Tweet.all
		erb :'tweets/feed'
	end

	post '/tweets' do 
		if params["content"].present?
			Tweet.create(content: params["content"], user_id: session[:user_id])
			@tweets = Tweet.all
			erb  :'tweets/feed'
		else
			@user = User.find(session[:user_id])
			erb :'users/show'
		end
	end

	get '/tweets/:id' do 
		@tweet = Tweet.find(params[:id])
		erb :'tweets/show'
	end

	get '/tweets/:id/edit' do 
		@tweet = Tweet.find(params[:id])
		erb :'tweets/edit'
	end

	patch '/tweets/:id' do  
		@tweet = Tweet.find(params[:id])
		@tweet.update(content: params["content"])
		redirect "tweets/#{@tweet.id}"
	end

	delete '/tweets/:id/delete' do
		@tweet = Tweet.find(params[:id])
		@tweet.destroy
		redirect '/tweets'
	end

end