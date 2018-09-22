class TweetsController < ApplicationController
	get '/tweets' do
		if logged_in?
			erb :'/tweets/tweets'
		else
			redirect '/login'
		end
	end

	get '/tweets/new' do
		if logged_in?
			erb :'/tweets/new'
		else
			redirect '/login'
		end
	end

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find_by(id: params[:id])
			erb  :'/tweets/show_tweet'
		else
			redirect '/login'
		end
	end

	post '/tweets/new' do
		#binding.pry
		if logged_in? && !(params[:content].empty?)
			@tweet = Tweet.new(content: params["content"], user_id: current_user.id)
			@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/:id/edit' do
		if logged_in?
			@tweet = Tweet.find_by(id: params[:id])
			erb :'/tweets/edit_tweet'
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id/edit' do
		@tweet = Tweet.find_by(id: params[:id])
		@tweet.content = params["content"]
		if !(params["content"].empty?)
			@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect "/tweets/#{@tweet.id}/edit"
		end
	end

	delete '/tweets/:id/delete' do
		@tweet = Tweet.find_by(params[:id])
		@tweet.destroy
		redirect '/tweets'
	end
end
