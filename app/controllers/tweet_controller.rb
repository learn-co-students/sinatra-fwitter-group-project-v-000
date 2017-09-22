class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :"tweets/edit_tweet"
  end

  post '/tweets' do
    #binding.pry
    if !(params[:content] == "")
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      current_user.tweets << @tweet
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

end
