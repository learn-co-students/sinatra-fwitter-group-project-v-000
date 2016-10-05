class TweetsController < Controller

	get '/tweets' do 
		if logged_in?
			erb :'tweets/tweets'
		else
			redirect '/login'
		end
	end

	get '/tweets/new' do
		if logged_in?
			erb :'tweets/create_tweet'
		else
			redirect '/login'
		end
	end

	post '/tweets' do 
		@tweet = current_user.tweets.build(content: params[:content])
		if	@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :'tweets/show_tweet'
		else
			redirect '/login'
		end
	end

	get '/tweets/:id/edit' do
		redirect '/login' if !logged_in?
		@tweet = Tweet.find(params[:id])
		redirect '/tweets' if @tweet.nil? || @tweet.user.nil? || @tweet.user != current_user
		erb :'tweets/edit_tweet'
	end

	delete '/tweets/:id/delete' do 
		@tweet = Tweet.find(params[:id])
		@tweet.delete if @tweet.user == current_user
		redirect '/tweets'
	end

	patch '/tweets' do 
		@tweet = Tweet.find(params[:id]) 
		if @tweet.update(content: params[:content])
			redirect "/tweets/#{@tweet.id}"
		else
			redirect "/tweets/#{params[:id]}/edit"
		end
	end

end