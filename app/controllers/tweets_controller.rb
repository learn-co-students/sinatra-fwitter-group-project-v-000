class TweetsController < ApplicationController

  get '/tweets' do
    if User.logged_in?(session)
      @user = User.current_user(session)
      erb :"tweets/tweets"
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    if User.logged_in?(session)
      @user = User.current_user(session)
      erb :"tweets/new"
    else
      redirect to '/login'
    end
  end
  
  post '/tweets' do
    if invalid_tweet?
      #set a flash message
      redirect to '/tweets/new'
    else
      user = User.current_user(session)
      user.tweets.create(:content => params[:content])
      redirect to '/tweets'
    end
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if User.logged_in?(session) && User.current_user(session).tweets.include?(@tweet)
      erb :"tweets/show"
    else
      redirect to '/login'
    end
  end
  
  delete '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if User.logged_in?(session) && User.current_user(session).tweets.include?(@tweet)
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if User.logged_in?(session) && User.current_user(session).tweets.include?(@tweet)
      erb :"tweets/edit"
    else
      redirect to '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if User.logged_in?(session)
      user = User.current_user(session)
      if user.tweets.include?(@tweet) && !invalid_tweet?
        @tweet.update(:content => params[:content])
        redirect to "/tweets/#{@tweet.id}"
      elsif user.tweets.include?(@tweet)
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end
  
  def invalid_tweet?
    params[:content].empty? || params[:content].nil?
  end

end
