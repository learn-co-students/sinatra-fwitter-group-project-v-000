class TweetsController < ApplicationController

	configure do
		set :sessions_secret, "3lklk2ml23-0op;l"
    	enable :sessions
	end

	get '/tweets' do
  	if !logged_in?
  		redirect '/login'
  	end

  	@user = current_user
	  @tweets = Tweet.all
	
	  erb :'tweets/tweet'
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
		@user = current_user

		if @tweet.user == @user 
			erb :'tweets/edit_tweet'
		else
			redirect '/tweets'
		end
	end

	delete '/tweets/:id' do
		if !logged_in?
			redirect '/login'
		end

		@tweet = Tweet.find(params[:id])
		@user = current_user

		if @tweet.user == @user
			@tweet.delete
			redirect '/tweets'
		else
			redirect '/tweets'
		end
	end

	patch '/tweets/:id' do
		@tweet = Tweet.find(params[:id])
		@user = current_user

		if @tweet.user == @user
			if !params[:content].empty?
				@tweet.update(:content => params[:content])
				redirect "/tweets/#{@tweet.id}"	
			else
				redirect "/tweets/#{@tweet.id}/edit"	
			end
		else
			redirect '/tweets'
		end
	end

	post '/tweets' do
		@user = current_user
		@tweet = Tweet.new(:content => params[:content])
		if @tweet.save
			@tweet.user = @user
			@tweet.save

			redirect '/tweets'
		else
			redirect '/tweets/new'
		end
	end
end
