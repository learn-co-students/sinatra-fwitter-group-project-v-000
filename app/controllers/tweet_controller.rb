require 'rack-flash'
class TweetController < ApplicationController
  use Rack::Flash
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :index
    else 
      redirect '/login'
    end
  end 

  get '/tweets/new' do
  	if logged_in?
  		@user = current_user
  		erb :'tweets/create_tweet'
  	else
  		redirect '/login'
  	end 
  end 

  post '/tweets/new' do 
  	if params[:content].empty?
  		redirect '/tweets/new'
  	else
  		@user = current_user
  		params[:user_id] = @user.id
  		@tweet = Tweet.create(params)
  		redirect "/users/#{@user.slug}"
  	end 
  end 

  get '/tweets/:id' do
  	if logged_in?
  		@user = current_user
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'tweets/show_tweet'
  	else
  		redirect '/login'
  	end 
  end 

  get '/tweets/:id/edit' do
  	if logged_in?
  		@user = current_user
  		@tweet = Tweet.find_by_id(params[:id])
		erb :'tweets/edit_tweet'
	else
		redirect '/login'
	end 
  end

  patch '/tweets/:id' do
  	if logged_in? && !params[:content].empty?
  		@user = current_user
  		@tweet = Tweet.find_by_id(params[:id])
  		if @tweet.user_id == @user.id
  			@tweet.content = params[:content]
  			@tweet.save
  			redirect "/tweets/#{params[:id]}"
  		end 
  	else
  		redirect "/tweets/#{params[:id]}/edit"
  	end 
  end 

  delete '/tweets/:id/delete' do
  	if logged_in?
  		@user = current_user	
  		@tweet = Tweet.find_by_id(params[:id])
  		if @tweet.user_id == @user.id
  			@tweet.delete
  			redirect "/tweets"
  		end 
  	else 
  		redirect "/tweets/#{params[:id]}"
  	end 
  end  

end 