class TweetsController < ApplicationController


	get '/tweets' do 
		if session[:user_id]
	  	@tweets = Tweet.all
    	erb :'/tweets/index' 
    else
    	redirect '/login'
    end
  end

  get '/tweets/new' do 
  	if logged_in? # session[:user_id]
    	@tweets = Tweet.all
  	  erb :'/tweets/new' 
  	else
  		redirect '/login'
  	end
  end

	post '/tweets' do 
		if params[:content] == ""
			redirect '/tweets/new'
		else
			@tweet = current_user.tweets.create(content: params[:content])
			redirect "/tweets/#{@tweet.id}"
		end
	end

	get '/tweets/:id' do 
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])
			erb :'tweets/show' 
		else
			redirect '/login' 
		end
	end

	get '/tweets/:id/edit' do 
		if logged_in?
			@tweet = Tweet.find_by_id(params[:id])
			if @tweet.user_id == current_user.id
				erb :'tweets/edit' 
			else
				redirect '/tweets' 
			end
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id' do 
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
		if logged_in?  # session[:user_id]
  	  @tweet = Tweet.find_by_id(params[:id]) 
  	  if @tweet.user_id == current_user.id 
	  	  @tweet.delete
	  	  redirect '/tweets'
	  	else
	  		redirect '/tweets'
	  	end
	  else
	  	redirect '/login'
	  end
  end

end
	

 

 
  
