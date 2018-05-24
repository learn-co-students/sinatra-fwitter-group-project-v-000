class TweetsController < ApplicationController


	get '/tweets' do

		if logged_in?
			@tweets = Tweet.all

			erb :'tweets/tweets'
		else
			redirect to '/login'
		end
	end


	post '/tweets' do
		if logged_in?
			if params[:tweet] == ""
				redirect to "/tweets/new"
			else
				Tweet.all.clear
				@user = User.find_by(email: session[:user_id][:email])
				@user.tweets << Tweet.create(content: params[:tweet])
				
				redirect to '/tweets'
			end
		end

	end




	get '/tweets/new' do 


		if logged_in?
			erb :'tweets/create_tweet'
		else
			redirect to "/login"
		end

	end

	get '/tweets/:id/edit' do

		if logged_in?
			@user = current_user
			@tweet = Tweet.find_by(id: params[:id])
		else
			redirect to '/login'
		end

		if @user.id == @tweet.user_id
			@tweet = Tweet.find_by(id: params[:id])
			erb :'tweets/edit_tweet'
		else
			
			redirect to "/tweets/#{@tweet.id}"
		end

	end

	delete '/tweets/:id/delete' do 

		if logged_in?
			@user = current_user
			@tweet = Tweet.find_by(id: params[:id])
		else
			redirect to '/login'
		end

		if @user.id == @tweet.user_id
			@tweet = Tweet.find_by(id: params[:id])
			@tweet.delete
			redirect to '/tweets'

			# erb :'tweets/edit_tweet'
		else
			
			redirect to "/tweets/#{@tweet.id}"
		end

		# @tweet = Tweet.find_by(id: params[:id])
		# @tweet.delete
		# redirect to '/tweets'


	end


	get '/tweets/:id' do 

		if logged_in?
			@tweet = Tweet.find_by(id: params[:id])
			erb :'tweets/show_tweet'
		else
			redirect to '/login'
		end


	end

	patch '/tweets/:id' do 

	
		if params[:tweet] == ""
			redirect to "/tweets/#{params[:id]}/edit"
		else

			@tweet = Tweet.find_by(id: params[:id])

			@tweet.content = params[:tweet]
			@tweet.save
			
			redirect to "/tweets"

		end

	end






end