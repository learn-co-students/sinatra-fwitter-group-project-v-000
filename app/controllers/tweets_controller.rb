class TweetsController < ApplicationController

	get '/tweets' do 
		@tweets = Tweet.all
		erb :'tweets/index'
	end

	get '/tweets/new' do 
		erb :'tweets/new'
	end

	post '/tweets' do
		@tweet = Tweet.new(content: params[:content])
		@tweet.save

		redirect '/tweets'
	end

	get '/tweets/:id' do 

		@tweet = Tweet.find_by_id(params[:id])
		erb :'tweets/show'
	end

	get '/tweets/:id/edit' do
		@tweet = Tweet.find_by_id(params[:id])
		erb :'tweets/edit'
	end

	patch '/tweets/:id' do
		binding.pry
	@tweet = Tweet.find_by_id(params[:id])
	@tweet.update(content: params[:content]) unless params[:content].blank?
	@tweet.save	

	redirect "/tweets/#{@tweet.id}"
	end

	delete '/tweets/:id/delete' do 
		@tweet = Tweet.find(params[:id])
		@tweet.delete

		redirect "/tweets"
	end


end