class TweetsController < ApplicationController

	get '/tweets' do
  	if logged_in?
  		@tweets = Tweet.all
  		erb :'tweets/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'/tweets/create_tweet'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets' do
	  	@tweet = current_user.tweets.new(params)
	  	if @tweet.save
	  		redirect '/tweets'
	  	end
	  redirect '/tweets/new'
  end

  get '/tweets/:id' do
  	if logged_in?
	  	@tweet = Tweet.find_by_id(params[:id])
	  	erb :'tweets/show_tweet'
	  else
	  	redirect '/login'
	  end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		if @tweet.user_id == current_user.id
  			erb :'tweets/edit_tweet'
  		else
  			redirect '/tweets'
  		end
  	else
  		redirect '/login'
  	end
  end

  patch '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	if @tweet.content != params[:content]	&& @tweet.user_id == current_user.id  	
	  	@tweet.content = params[:content]
	  	if @tweet.save
	  		redirect "/tweets/#{@tweet.id}"
	  	end
	  end
	  redirect "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id/delete' do
  	@tweet = current_user.tweets.find_by_id(params[:id])
  	if @tweet && @tweet.destroy
  		redirect '/tweets'
  	else
  		redirect "/tweets/#{tweet.id}"
  	end
  end
end