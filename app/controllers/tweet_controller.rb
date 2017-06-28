class TweetController < ApplicationController

	get '/tweets/new' do 
		if logged_in?
		erb :'/tweets/create_tweet'
	else
		redirect to '/login'
	end
	end

  post '/tweets' do
  	if params[:content] != ""
	  	@tweet = Tweet.new(params)
	  	@tweet.user = current_user
	  	@tweet.save
	  	redirect '/tweets'
	  end
	  redirect '/tweets/new'
  end


	get '/tweets' do 
		if logged_in?
		@tweets = Tweet.all
		erb :'/tweets/tweets'
	else
		redirect to '/login'
	end
	end

  get '/tweets/:id' do
  	if logged_in?
	  	@tweet = Tweet.find_by_id(params[:id])
	  	erb :'tweets/show_tweet'
	  else
	  	redirect '/login'
	  end
  end

	get '/tweets/:id/edit' do 
		if logged_in?
		@tweet = Tweet.find_by_id(params[:id])
		erb :'/tweets/edit_tweet'
	else
		redirect to '/login'
	end

	end

	patch '/tweets/:id' do 
		@tweet = Tweet.find_by_id(params[:id])
		if params[:content].blank?
			redirect to "/tweets/#{@tweet.id}/edit"
		else
			@tweet.content = params[:content]
	  		@tweet.save
	  		redirect "/tweets/#{@tweet.id}"
		end

	end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

end