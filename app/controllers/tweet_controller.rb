class TweetController < ApplicationController
	#==================== NEW ===============================
	get '/tweets/new' do
		if !logged_in?
			redirect to "/login"
		else
			erb :'/tweets/create_tweet'
		end
	end

	post '/tweets' do
		if !params[:content].empty?
			@user = current_user
			@user.tweets.build(params).save
			redirect to "tweets"
		else
			redirect to "tweets/new"
		end
	end
	#--------------------------------------------------------


	#==================== SHOW ==============================
	get '/tweets/:tweetid' do
		if logged_in? && tweet_exists?(params[:tweetid])
			@tweet = Tweet.find_by(params[:tweetid])
			erb :'/tweets/show_tweet'
		elsif (logged_in? && !tweet_exists?(params[:tweetid]))
			erb :'/tweets/error'
		else
			redirect to "/login"
		end
	end
	#--------------------------------------------------------


	#==================== EDIT ==============================
	get '/tweets/:tweetid/edit' do
		if logged_in?
			@tweet = current_user.tweets.find(params[:tweetid])
			erb :'/tweets/edit_tweet'
		else
			redirect to "/login"
		end
	end

	patch '/tweets/:tweetid' do
		if !params[:content].empty?
			@tweet = current_user.tweets.find(params[:tweetid])
			@tweet.update(content: params[:content])
			erb :'/tweets/show_tweet'
		else
			redirect to "/tweets/#{params[:tweetid]}/edit"
		end
	end
	#--------------------------------------------------------


	#==================== DELETE ============================
	delete '/tweets/:tweetid' do
		if logged_in?
			current_user.tweets.find_by(params[:tweetid]).delete
			redirect to "/tweets"
		end
	end
	#--------------------------------------------------------

end