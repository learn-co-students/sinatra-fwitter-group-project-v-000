class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

	post '/tweets' do
		@tweet = Tweet.new(params)
		@tweet.user_id = session[:user_id]
    if logged_in? && @tweet.save
			# current_user.tweets << @tweet
			# binding.pry
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    elsif !logged_in?
      redirect to '/login'
    end
  end
 
  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete if @tweet.user == current_user
    redirect to '/tweets' 
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if tweet.user == current_user
      redirect to (tweet.update(content: params[:content]) ? "/tweets/#{tweet.id}" : "/tweets/#{tweet.id}/edit")
    else
      redirect to '/tweets'
    end
  end

end 