class TweetsController < ApplicationController

	
	get '/tweets' do 

		@tweets = Tweet.all 
		if logged_in?
		erb :"/tweets/tweets"
	    else
	    redirect to "/login"
		end

	end


	get '/tweets/new' do 
		if logged_in?
		erb :"/tweets/create_tweet"
		else
			redirect to "/login"
		end

	end


	post '/tweets' do 
		if logged_in?
			if !params[:content].empty?
				@tweet = Tweet.create(content: params[:content])
				current_user.tweets << @tweet
				current_user.save
				redirect to "/tweets/#{@tweet.id}"
			else
			redirect to "/tweets/new"
			end
		else
			redirect to "/login"
		end
	end

	get '/tweets/:id' do

		@tweet = Tweet.find(params[:id])
		if logged_in?
		erb :"tweets/show_tweet"
		else
			redirect to "/login"
		end
	end

	get '/tweets/:id/edit' do

		if !logged_in?
			redirect to "/login"
		else
			@tweet = Tweet.find(params[:id])
			if current_user.id == @tweet.user_id
				erb :"/tweets/edit_tweet"
			else
				redirect to "/tweets"
			end
		end
	end


	

	patch '/tweets/:id' do 
		if logged_in? 
		@tweet = Tweet.find_by_id(params[:id])

		if !params[:content].empty?

			@tweet.update(content: params[:content])
				current_user.save
			redirect to "/tweets/#{@tweet.id}"
		else
			redirect to "/tweets/#{@tweet.id}/edit"
		end

		redirect to "/login"
		end
	end

	delete '/tweets/:id/delete' do 
		if !logged_in?
			redirect to "/login"
		else
		@tweet = Tweet.find_by_id(params[:id])
			if @tweet && current_user.id == @tweet.user_id
			@tweet.delete
				redirect to "/tweets"

			else
			"/tweets/#{@tweet.id}"
			end
		end

	end




end


