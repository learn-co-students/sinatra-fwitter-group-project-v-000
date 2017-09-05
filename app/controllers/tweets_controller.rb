class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?
			@tweets = Tweet.all		
			erb :"tweets/tweets"
		else
			redirect to '/login'
		end
	end

	get '/tweets/new' do
		if logged_in?
			erb :'tweets/new'
		else
			redirect to '/login'
		end
	end

	post '/tweets/new' do
		@user = current_user
		if !params["content"].empty?
			@user.tweets.create(params)
		else
			redirect to '/tweets/new'	
		end
		@user.save
		
		redirect to '/tweets'
	end

	get '/tweets/:id' do
		if !logged_in?
			redirect '/login'
		end
		@tweet = Tweet.find(params[:id])
		erb :'tweets/show'
	end

	get '/tweets/:id/edit' do
		redirect to '/login' if !logged_in?
		@tweet = Tweet.find(params[:id])
		erb :'tweets/edit'	
	end

	patch '/tweets/:id/edit' do
		if !logged_in?
			redirect to '/login' 
		elsif logged_in? && params["content"] != ""
			@tweet = Tweet.find(params[:id])
			@tweet.update(content: params["content"])
		else
			redirect to "/tweets/#{params[:id]}/edit"
		end
		
		redirect to '/tweets'
	end

	delete '/tweets/:id/delete' do
		@tweet = Tweet.find(params[:id])
		if !logged_in?
			redirect to '/login'
		elsif current_user.tweets.include?(@tweet)
			Tweet.find(params[:id]).destroy
		end
		
		redirect to '/tweets'
	end
end