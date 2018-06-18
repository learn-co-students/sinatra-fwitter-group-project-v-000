class TweetsController < ApplicationController

	get '/tweets' do
  	if logged_in?
  		@user = User.find_by_id(session[:user_id])
  		@tweets = Tweet.all
  		erb :'/tweets/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'tweets/create_tweets'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets/new' do
  	if params[:content] != ""
	  	@tweet = Tweet.create(content: params[:content], user: current_user)
	  	@tweet.save
	  	redirect "/users/#{@tweet.user.slug}"
	 else
	 	redirect '/tweets/new'
	 end
  end

  get '/tweets/:id' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'/tweets/show_tweet'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'/tweets/edit_tweet'
  	else
  		redirect '/login'
  	end
  end

  patch '/tweets/:id' do
  	@tweet = Tweet.find_by_id(params[:id])
  	if params[:content] != ""
	  	@tweet.content = params[:content]
	  	@tweet.save
	  	redirect "/tweets/#{@tweet.id}"
	else
		redirect "/tweets/#{@tweet.id}/edit"
	end
  end

  delete '/tweets/:id/delete' do
  	# binding.pry
  	tweet = current_user.tweets.find_by(id: params[:id])
	if tweet && tweet.destroy
  		redirect "/tweets"
	else
		redirect "/tweets/#{params[:id]}"
	end
  end

end