class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?
			@user = User.find(session[:user_id])
		end
		@tweets = Tweet.all
		erb :'tweets/feed'
	end

	post '/tweets' do 
		@user = User.find(session[:user_id])
		if params["content"].present?
			Tweet.create(content: params["content"], user_id: session[:user_id])
			@tweets = Tweet.all
			erb :'tweets/feed'
		else
			flash[:message] = "Please enter a tweet!"
			erb :'users/show'
		end
	end

	get '/tweets/:id' do 
		if logged_in?
			@user = User.find(session[:user_id])
		end	
		@tweet = Tweet.find(params[:id])
		erb :'tweets/show'
	end

	get '/tweets/:id/edit' do 
		if logged_in?
			@user = User.find(session[:user_id])
		end	
		@tweet = Tweet.find(params[:id])
		erb :'tweets/edit'
	end

	patch '/tweets/:id' do 
		if logged_in?
			@user = User.find(session[:user_id])
		end		
		@tweet = Tweet.find(params[:id])
		if params["content"].present? 
			@tweet.update(content: params["content"])
			redirect "tweets/#{@tweet.id}"
		else
			flash[:message] = "Please enter your edit!"
			erb :'tweets/edit'
		end
	end

	delete '/tweets/:id/delete' do
		@tweet = Tweet.find(params[:id])
		@tweet.destroy
		redirect '/tweets'
	end

end