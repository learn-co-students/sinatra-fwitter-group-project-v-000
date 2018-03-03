class TweetsController < ApplicationController 


	get '/tweets' do 
		if logged_in?
			@user = current_user
			success
			erb :'/tweets/tweets'
		else
			please_login
			redirect '/login'
		end
	end


	get '/tweets/new' do 
		if logged_in?
			@user = current_user
			erb :'/tweets/create_tweet'
		else
			please_login
			redirect '/login'
		end
	end

	post '/tweets/new' do 
		if filled_out(params)
			@tweet = Tweet.create(content: params[:content])
			@tweet.id = Tweet.all.last.id
			@tweet.user_id = current_user.id
			@tweet.save
			success
			redirect '/tweets'
		else
			not_filled_out
			redirect '/tweets/new'
		end
	end


	get '/tweets/:id' do 
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :'/tweets/show_tweet'
		else
			please_login
			redirect '/login'		
		end
	end


	get '/tweets/:id/edit' do 
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :'/tweets/edit_tweet'
		else
			please_login
			redirect '/login'
		end
	end

	post '/tweets/:id/edit' do 
		@tweet = Tweet.find(params[:id])
			if current_user.id == @tweet.user_id
				@tweet.update(content: params[:content])
				success
				erb :'/tweets/show_tweet'
			else
				failure
				redirect "/tweets/#{@tweet.id}"
			end
	end	


	delete '/tweets/:id/delete' do 
		@tweet = Tweet.find(params[:id])
			if current_user.id == @tweet.user_id
				@tweet.delete
				redirect '/tweets'
			else
				failure
			  redirect "/tweets/#{@tweet.id}"
			end
	end


end
