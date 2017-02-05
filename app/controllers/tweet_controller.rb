class TweetController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    if @tweet.valid?
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
      else
        redirect to '/login'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id && !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect to '/tweets'
    elsif @tweet.user_id == current_user.id && params[:content].empty?
      redirect to "tweets/#{@tweet.id}/edit"
    elsif @tweet.user_id != current_user.id
      redirect to '/login'
    end
  end

  delete '/tweets/:id' do
    @tweet = current_user.tweets.find_by(id: params[:id])
    if @tweet
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end
end
