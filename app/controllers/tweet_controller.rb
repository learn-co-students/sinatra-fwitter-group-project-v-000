class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?   
	  erb :'tweets/index'
	else
	  redirect to '/login'
	end  
  end

  get '/tweets/new' do
  	if logged_in?
  	  erb :'tweets/new'
  	else
  		redirect to '/login'
  	end  
  end

  post '/tweets' do
    @user = User.find_by_id(session[:user_id])
    if params[:content] == ""
    	redirect to '/tweets/new'
    else
  	    @user.tweets.create(content: params[:content])
  	    @user.save
  	    redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    if logged_in?
	    @tweet = Tweet.find_by_id(params[:id])
	  	erb :'tweets/show'
	  else
	  	redirect '/login'
	  end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
  		erb :'tweets/edit'
  	else
  		redirect '/login'
  	end	
  end

  post '/tweets/:id' do
  	if params[:content] == ""
  		redirect to "/tweets/#{params[:id]}/edit"
  	else
  		@tweet = Tweet.find_by_id(params[:id])
  	  @tweet.content = params[:content]
  	  @tweet.save
  	end
  end
  
  delete '/tweets/:id/delete' do
  	if current_user.tweets.include?(Tweet.find_by_id(params[:id]))
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to "/tweets"
    end  
  end

end












