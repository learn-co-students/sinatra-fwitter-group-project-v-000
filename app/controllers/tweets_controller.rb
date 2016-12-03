class TweetsController < ApplicationController
	
	get '/tweets' do
    	if logged_in?
      	@user = User.find(session[:id])
      	erb :'/tweets/tweets'
    	else
      	redirect "/login"
    	end
 	end

 	post '/tweets' do
    	@tweet = Tweet.create(content: params[:content], user_id: session[:id])
    	redirect "/tweets/new"
  	end

  	get '/tweets/new' do
    	if logged_in?
      	erb :'/tweets/create_tweet'
    	else
      	redirect "/login"
    	end
  	end

  	get '/tweets/:id' do
    	if logged_in?
      		@tweet = Tweet.find(params[:id])
      		erb :'/tweets/show_tweet'
    	else
      		redirect "/login"
    	end
  	end

  	get '/tweets/:id/edit' do
    	if logged_in?
      	@tweet = Tweet.find(params[:id])
      		if current_user == @tweet.user
         	erb :'tweets/edit_tweet'
       		else
         	redirect "/tweets"
       	end
    	else
      		redirect "/login"
    	end
  	end

  	patch '/tweets/:id' do
    	@tweet = Tweet.find(params[:id])
    	@tweet.update(content: params[:content])
    	redirect "/tweets/#{session[:id]}/edit"
  	end

  	delete '/tweets/:id/delete' do
    	#@tweet = Tweet.find(params[:id])
    	#if logged_in? && current_user == @tweet.user
      	#	@tweet.delete
      	#	redirect "/tweets"
    	#else
      	#	redirect "/login"
    	#end
    
    	tweet = current_user.tweets.find_by(id: params[:id])
    	if tweet && tweet.destroy
    		redirect "/tweets"
    	else
    		redirect "/tweets/#{tweet.id}"
    	end
    end
  	end


end