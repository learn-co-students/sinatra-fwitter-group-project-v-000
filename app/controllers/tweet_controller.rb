class TweetController < ApplicationController


  get '/tweets/new' do
    if logged_in?
      erb :new
    else
      redirect '/login'
    end
  end

  post '/tweets/delete' do 
    # binding.pry
    tweet = Tweet.find_by(id: params[:tweet_id]) 
    tweet.destroy if tweet.user_id == current_user.id
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :tweet
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :tweets
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    redirect '/login' if !logged_in?
    redirect '/tweets/new' if params[:content].empty?
    @tweet = current_user.tweets.create(content: params[:content]) 
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    # binding.pry
    redirect '/login' if !logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :edit
  end
  
  patch '/tweets/:id/edit' do
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

end