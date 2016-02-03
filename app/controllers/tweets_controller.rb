class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?
			erb :'tweets/tweets'
		else
			redirect '/login' #put in an error message here 'Please log in to view content'
		end
	end
	
	get '/tweets/new' do
		if logged_in?
			erb :'tweets/new'
		else
			redirect '/login'
		end 
	end

	post '/tweets' do
		if current_user.tweets.create(content: params[:content]).save
			redirect '/users/show'
		else
			redirect '/tweets/new'  #put in an error message here "There was an error, please try again"
		end
	end

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])
			erb :'tweets/show'
		else
			redirect 'login'
		end
	end

	get '/tweets/:id/edit' do
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])
			erb :'tweets/edit'
		else
			redirect 'login'
		end
	end

	patch '/tweets/:id' do
		@tweet = Tweet.find_by_id(params[:id])
		if @tweet.update(content: params[:content])
			redirect :'users/show'
		else
			redirect "/tweets/#{@tweet.id}/edit"
		end
	end

	delete '/tweets/:id/delete' do
		@tweet = Tweet.find_by_id(params[:id])
		@tweet.destroy if @tweet.user_id == current_user.id
		redirect '/tweets'
	end

end