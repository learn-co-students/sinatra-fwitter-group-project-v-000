class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
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
   get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    @user = User.find_by(id: session[:user_id])
    if !logged_in?
      redirect to '/login'
    elsif logged_in? && @user.tweets.include?(@tweet)
      erb :"tweets/edit_tweet"
    else
      redirect to '/tweets'
    end
  end
   delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
     # @tweet = Tweet.find_by(params[:id])
    # @user = User.find_by(id: session[:user_id])
    # if !logged_in? || !@user.tweets.include?(@tweet)
    #   redirect to '/tweets'
    # elsif logged_in? && @user.tweets.include?(@tweet)
    #   @user.tweets.delete(@user.tweets.last)
    #   @tweet.destroy
    #   redirect to "/users/#{@user.slug}"
    # end
  end
   get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      erb :"tweets/show"
    else
      redirect to '/login'
    end
  end
   post '/tweets/new' do
    @user = User.find_by(session[:user_id])
    if !params["tweet"]["content"].empty?
      @tweet = Tweet.create(content: params["tweet"]["content"])
      @tweet.user = @user
      @tweet.save
      @user.tweets << @tweet
      @user.save
    end
    redirect to "/tweets/#{@tweet.id}"
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

end
