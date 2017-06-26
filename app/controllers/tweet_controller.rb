class TweetController < ApplicationController
  
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
  		redirect "/users/#{@user.username}"
  	end 
  end 

end 