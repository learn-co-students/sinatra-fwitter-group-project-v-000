class TweetsController < ApplicationController

  get '/tweets' do
		if logged_in?
			@user = current_user
			@tweets = Tweet.all
			erb :'/tweets/tweets'
		else
			redirect '/login'
		end
	end

  get '/tweets/new' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/new'
    else
      redirect '/login'
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

  post '/tweets' do
    if params[:content] == ''
      redirect to '/tweets/new'
    else
      user = current_user
      tweet = Tweet.create(content: params[:content])
      tweet.user = current_user
      tweet.save
      redirect to "/tweets/#{tweet.id}"
    end
  end

  get '/tweets/:id/edit' do
   @tweet = Tweet.find_by_id(params[:id])
    if logged_in?
        erb :'/tweets/edit_tweet'
    elsif logged_in?
        redirect '/tweets'
    else
        redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @user = User.find_by(id: session[:user_id])
    if logged_in? && @user.tweets.include?(@tweet) && !params["tweet"]["content"].empty?
      @tweet.update(content: params["tweet"]["content"])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
		@tweet = Tweet.find_by_id(params[:id])
		if current_user.id == @tweet.user.id
			@tweet.delete
			redirect to '/tweets'
		else
			redirect to '/tweets'
		end
	end


end
