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
		if logged_in?
			erb :'/tweets/create_tweet'
		else
			redirect to '/login'
		end
	end

	post '/tweets/new' do
		if logged_in? && (params[:content] != "")
			@tweet = current_user.tweets.build(content: params["content"])
				@tweet.save
			erb :'/tweets/show_tweet'
		end
	end

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])
			erb :'/tweets/show_tweet'
		else
			redirect to '/login'
		end

	end

	get '/tweets/:id/edit' do
		if logged_in? 
    		@tweet = Tweet.find(params[:id])
    		@tweet.save
			erb :'/tweets/edit_tweet'

		else
			redirect to '/login'
  		end
  	end


  	patch '/tweets/:id' do
  		if logged_in? && (params[:content].empty?)
  			redirect to "/tweets/#{params[:id]}/edit"
  		else
    		@tweet = Tweet.find_by_id(params[:id])
	   		@tweet.content = params[:content]
    		@tweet.save
			erb :'/tweets/show_tweet'
		end
  	end

  	delete '/tweets/:id/delete' do
  		if logged_in? 
    		@tweet = Tweet.find_by_id(params[:id])
    		@tweet.id = current_user.id
    		@tweet.delete
    		erb :'/tweets/show_tweet'
    	end

  	end


end
