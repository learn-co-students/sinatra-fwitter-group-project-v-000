class TweetsController < ApplicationController

	# index
	get '/tweets' do 
		if logged_in? && current_user
			@tweets = Tweet.all
			erb :'tweets/tweets'
		else
			redirect '/login'
		end
	end

	# new
	get '/tweets/new' do 
		erb :'tweets/new'
	end

	# create
	post '/tweets' do 
		if logged_in? && current_user
			@tweet = Tweet.new(content: params[:content])
			@tweet.user_id = current_user.id
			@tweet.save
			redirect "tweets/#{@tweet.id}"
		else
			redirect '/login'
		end
	end

	# show
	get '/tweets/:id' do
		@tweet = Tweet.find(params[:id])
		erb :'tweets/show_tweet'
	end

	# edit
	get '/tweets/:id/edit' do
		@tweet = Tweet.find(params[:id])
		if logged_in? && current_user && @tweet.content.present?
			erb :'tweets/edit_tweet'
		else
			redirect '/login'
		end
	end

	# update
	patch '/tweets/:id' do 
		@tweet = Tweet.find(params[:id])
		@tweet.content = params[:content]
		@tweet.save
		erb :'tweets/show_tweet'
	end

	# delete
	delete '/tweets/:id' do 
  	@tweet = Tweet.find(params[:id])
  	@tweet.delete
  	redirect "/tweets"
  end

end
