class TweetController < ApplicationController

	get '/tweets' do 
		if logged_in?
			@tweets = Tweet.all
			erb :'/tweets/tweets'
		else
			redirect "/login"
		end
	end

	get '/tweets/new' do 
		if logged_in?

			if !session[:content] 
				session[:content] = true
				@content = false
			end

			erb :'/tweets/create_tweet'
		else
			redirect to "/login"
		end
	end

	post '/tweets' do 
		content = Tweet.new(content: params[:content])

		if !!content.save
			current_user.tweets << content
			current_user.save
		else 
		session[:content] = false
		redirect '/tweets/new'	
		end
	end

	get '/tweets/:id' do 
		if logged_in?
			@tweet = Tweet.find(params[:id])

			@current_user = current_user
			if session[:tweet] == "delete"
				session[:tweet] = ""
				@delete = "delete"
			elsif session[:tweet] == "edit"
				session[:tweet] = ""
				@edit = "edit"
			end

			erb :'/tweets/show_tweet'
		else
			redirect "/login"
		end	
	end

	delete '/tweets/:id/delete' do 
		tweet = Tweet.find(params[:id])
		if current_user.id == tweet.user.id
			Tweet.delete(params[:id])
			redirect to '/tweets'
		else
			session[:tweet] = "delete"
			redirect to "/tweets/#{tweet.id}"
		end
	end

	get '/tweets/:id/edit' do 
		if logged_in?
			@tweet = Tweet.find(params[:id])

			erb :'/tweets/edit_tweet'
		else
			redirect "/login"
		end
	end

	patch '/tweets/:id' do
		@tweet = Tweet.find(params[:id])

		if current_user.id == @tweet.user.id

	 		@tweet.content = params[:content]
	 		if !!@tweet.save
	 			redirect to "/tweets/#{@tweet.id}"
	 		else
	 			redirect to "/tweets/#{@tweet.id}/edit"
	 		end
	 	else
	 		session[:tweet] = "edit"
	 		redirect to "/tweets/#{@tweet.id}"
	 	end
	end
end