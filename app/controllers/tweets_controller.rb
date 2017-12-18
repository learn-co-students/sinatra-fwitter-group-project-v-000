class TweetsController < ApplicationController
	get '/tweets' do
		if logged_in?
			@user = User.find(current_user.id)
			erb :"/tweets/tweets"
		else
			redirect to "/login"
		end
	end

	get '/tweets/new' do
		if logged_in?
			@user = User.find(current_user.id)
			erb :"tweets/create_tweet"
		else
			redirect to "/login"
		end
	end

	post '/tweets' do
		if params[:content] == ""
			redirect to "/tweets/new"
		else
			@user = User.find(current_user.id)
			@tweet = Tweet.create(content: params[:content])
			@user.tweets << @tweet
			redirect to "/tweets/#{@tweet.id}"
		end
	end

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :"tweets/show_tweet"
		else
			redirect to "/login"
		end
	end

	get '/tweets/:id/edit' do
		if logged_in?
			@user = User.find(current_user.id)
			@tweet = Tweet.find(params[:id])
			if @tweet.user_id == current_user.id # make sure that the only person who could edit is the one who created the tweet
				erb :"tweets/edit_tweet"
			else
				redirect to "/tweets"
			end
		else
			redirect to "/login"
		end
	end

	patch '/tweets/:id' do
		@tweet = Tweet.find_by_id(params[:id])
		if params[:content] == ""
			redirect to "/tweets/#{params[:id]}/edit"
		else
			@tweet.content = params[:content]
			@tweet.save
			redirect to "/tweets"
		end
	end

	post '/tweets/:id/delete' do
		tweet = Tweet.find(params[:id])
		if tweet.user_id == current_user.id
			tweet.delete
			tweet.save
			redirect to "/tweets"
		else
			redirect to "/tweets"
		end
	end

end
