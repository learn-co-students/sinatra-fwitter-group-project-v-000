class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      erb :"tweets/tweets"
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
    @user = current_user
    if params.all? {|key, value| value != ""}
      @user.tweets.build(content: params[:content])
      @user.save
      redirect "users/#{@user.slug}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet  = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet  = Tweet.find(params[:id])
    redirect "/tweets/#{@tweet.id}/edit"
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet  = Tweet.find(params[:id])
      if tweet_ownership?(@tweet)
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet  = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet  = Tweet.find(params[:id])
    if logged_in? && tweet_ownership?(@tweet)
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
