class UserController < ApplicationController

	get '/tweets/new' do 
		if logged_in?
			erb :new
		else
			redirect '/login'
		end
	end

	get '/tweets' do
		if logged_in?
			@user = current_user
			@tweets = Tweet.all
			erb :show
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		if params[:content] == ""
			flash[:message] = "Can not create a tweet without content"
			redirect '/tweets/new'
		else
			tweet = Tweet.create(user_id: current_user.id, content: params[:content])
			redirect "/tweets"
		end
	end

	get '/users/:slug' do 
		@user = User.find_by_slug(params[:slug])
		if @user != nil
			erb :users_tweets
		else
			redirect '/tweets'
		end
	end

	get '/tweets/:id' do 
		@tweet = Tweet.find(params[:id])
		if logged_in?
			if @tweet != nil
				erb :show_single_tweet
			else
				redirect '/tweets'
			end
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id' do
		if params[:content] != ""
			@tweet = Tweet.find(params[:id])
			@tweet.update(content: params[:content])
			redirect "/tweets/#{@tweet.id}"
		else
			flash[:message] = "Tweet can not be blank."
			redirect "/tweets/#{params[:id]}/edit"
		end
	end

	get '/tweets/:id/edit' do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			if @tweet.user == current_user
				erb :edit
			else
				flash[:message] = "You can only view the edit for of your own tweets."
				redirect '/tweets'
			end
		else
			flash[:message] = "You can only edit/delete your own tweets."
			redirect '/login'
		end
	end

	delete '/tweets/:id/delete' do
		if logged_in? 
			@tweet = Tweet.find(params[:id])
			@tweet.destroy if @tweet.user == current_user
			flash[:message] = "Tweet has been deleted."
			redirect '/tweets'
		else
			redirect '/tweets'
		end
	end

end