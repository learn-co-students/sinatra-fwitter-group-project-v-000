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
		# TODO: refacor to if/else/if.  if logged_in? && tweet_exists?, then create the tweet and erb to the show_tweet page.  elsif logged_in? && !tweet_exists?, then redirect to an error page.
		if logged_in?
			@tweet = Tweet.find_by(params[:tweet_id])
			erb :'/tweets/show_tweet'
		else
			redirect to "/login"
		end
	end
	#--------------------------------------------------------


	#==================== EDIT ==============================
	get '/tweets/:tweetid/edit' do
		if logged_in?
			@tweet = Tweet.find_by(params[:tweet_id])
			erb :'/tweets/edit_tweet'
		else
			redirect to "/login"
		end
	end

	patch '/tweets/:tweetid' do
		if !params[:content].empty?
			@tweet = Tweet.find_by(params[:tweetid])
			@tweet.update(content: params[:content])
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