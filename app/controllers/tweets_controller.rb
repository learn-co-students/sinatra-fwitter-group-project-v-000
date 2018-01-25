class TweetsController < ApplicationController

  get '/tweets' do
  	if logged_in?
  		erb :'tweets/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'tweets/new'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/:id' do
  	if !logged_in?
  		redirect '/login'
  	end
  	@tweet = Tweet.find(params[:id])
  	erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
  	if !logged_in?
  		redirect '/login'
  	end
  	@tweet = Tweet.find(params[:id])
  	if @tweet.user.id != session[:user_id]
  		redirect "/tweets/#{@tweet.id}"
  	end
  	erb :'tweets/edit_tweet'
  end

  post '/tweets/new' do
  	if logged_in?
  		if params[:content] == ""
  			redirect 'tweets/new'
  		end
  		@tweet = Tweet.create(content: params[:content])
  		@tweet.user = current_user
  		@tweet.save
  		redirect "/tweets/#{@tweet.id}"
  	else
  		redirect "/login"
  	end
  end

  patch '/tweets/:id' do
  	if params[:content] == ""
  		redirect "/tweets/#{params[:id]}/edit"
  	end
  	@tweet = Tweet.find(params[:id])
  	@tweet.update(content: params[:content])
  	redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
  	@tweet = Tweet.find(params[:id])
  	if @tweet.user.id == session[:user_id]
  		@tweet.delete
  	else
  		redirect '/tweets'
  	end
  end
end