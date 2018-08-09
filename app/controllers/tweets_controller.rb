class TweetsController < ApplicationController
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

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :'tweets/show'
		else
			redirect to '/login'
		end
	end

	get '/tweets/:id/edit' do
		@tweet = Tweet.find_by_id(params[:id])
		user_ = @tweet.user if @tweet
		
		if logged_in? && @tweet && current_user.id == user_.id
			erb :'tweets/edit'
		else
			redirect to '/login'
		end
	end
	
	patch '/tweets/:id' do
		@tweet = Tweet.find(params[:id])
		user_ = @tweet.user
		
		if params[:content].empty?
			redirect to "/tweets/#{params[:id]}/edit"
		elsif logged_in? && current_user.id == user_.id
			@tweet.content = params[:content]
			@tweet.save
			redirect to '/tweets'
		else
			redirect to '/login'
		end
	end
	
	post '/tweets/new' do
		if params[:content].empty?
		 redirect to '/tweets/new'
		elsif logged_in?
			user_ = current_user
			twt_ = Tweet.new(content: params[:content])
			twt_.user = user_
			twt_.save

			redirect to '/tweets'
		else
			redirect to '/login'
		end
	end
	
	delete '/tweets/:id/delete' do
		tweet_ = Tweet.find_by_id(params[:id])
		
		if logged_in? && tweet_ && current_user.id == tweet_.user.id
			tweet_.delete
			redirect to '/tweets'
		else
			redirect to '/login'
		end
	end
end
