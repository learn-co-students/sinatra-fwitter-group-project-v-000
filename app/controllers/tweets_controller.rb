class TweetsController < ApplicationController

	get '/tweets' do
  	if logged_in?
  		@user = User.find_by_id(session[:user_id])
  		@tweets = Tweet.all
    	erb :'/tweets/index'
  	else
  	 	redirect "/login"
  	end
	end

	get '/tweets/new' do
  	if logged_in?
  		@user = User.find_by_id(session[:user_id])
  		erb :'/tweets/create_tweet'
  	else
  		redirect '/login'
  	end
	end

	post '/tweets' do
		if logged_in?
			if params[:content] == ""
				redirect '/tweets/new'
			else
				user = User.find_by_id(session[:user_id])
				@tweet = Tweet.create(content: params[:content])
			 	@tweet.user = user
			 	@tweet.save
				redirect to "/tweets/#{@tweet.id}"
			end
		else
			redirect '/login'
		end
	end

	get '/tweets/:id' do #show single tweet if logged in
		if logged_in?
    	@tweet = Tweet.find_by_id(params[:id])
    	@user = User.find_by_id(session[:user_id])
    	erb :'/tweets/show_tweet'
    else
    	redirect '/login'
    end
  end

  get '/tweets/:id/edit' do #load edit form
  	@tweet = Tweet.find_by_id(params[:id])
   	@user = User.find_by_id(session[:user_id])
  	if logged_in?
  		if @user = @tweet.user
  			erb :'/tweets/edit_tweet'
  		else
  			redirect "/tweets/#{@tweet.id}"
  		end
  	else
  		redirect '/login'
  	end
  end

	patch '/tweets/:id' do #edit and update tweet
		if params[:content] == ""
			redirect "/tweets/#{params[:id]}/edit"
		else
    	@tweet = Tweet.find_by_id(params[:id])
    	@tweet.content = params[:content]
    	@tweet.save
    	redirect "/tweets/#{@tweet.id}"
    end
  end


  delete '/tweets/:id/delete' do 
  	@tweet = Tweet.find_by_id(params[:id])
  	@user = User.find_by_id(session[:user_id])
    if @user == @tweet.user
  		@tweet.delete
  		redirect '/tweets'
  	else
  		redirect "tweets/#{@tweet.id}"
  	end
  end



end