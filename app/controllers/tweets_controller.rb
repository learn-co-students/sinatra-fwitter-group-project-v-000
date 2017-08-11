class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?(session)
		@tweets = Tweet.all	
			erb :'/tweets/tweets'
		else
			redirect '/login'
		end
	end

	get '/tweets/new' do
		if logged_in?(session)
			erb :'tweets/create_tweet'
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		if params[:content] == ""
			redirect '/tweets/new'
		else
			#create the tweet using the current users session id to match the user_id
			@tweet = current_user(session).tweets.create(content: params[:content], user_id: params[:user_id])
			redirect "/tweets/#{@tweet.id}"
		end
	end

	#get the information per user
	get '/tweets/:id' do
		if logged_in?(session)
			@tweet = Tweet.find_by_id(params[:id])
			erb :'/tweets/show_tweet'
		else
			redirect '/login'
		end
	end

	get '/tweets/:id/edit' do
		if logged_in?(session)
			@tweet = Tweet.find_by_id(params[:id])
			if @tweet.user_id == current_user(session).id
			erb :'/tweets/edit_tweet'
			else
				redirect '/tweets'
			end
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id' do
		if params[:content] == ""
			redirect "/tweets/#{params[:id]}/edit"
		else
			@tweet = Tweet.find_by_id(params[:id])
			@tweet.content = params[:content]
			@tweet.save
			redirect "/tweets/#{@tweet.id}"
		end
	end

	delete '/tweets/:id' do

		if logged_in?(session)
			@tweet = Tweet.find_by_id(params[:id])
			if @tweet.user_id == current_user(session).id
				@tweet.destroy
				redirect '/tweets'
			end
			redirect '/login'
		end
	end

end









