class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect 'users/login'
    else
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect 'users/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      # current_user.tweets.create[content: params[:content]]
      redirect "/tweets/#{@tweet.id}"
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
      binding.pry
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit'
      else
        erb :'tweets'
      end
    else
      redirect :"/tweets/#{@tweet.id}"
    end
  end

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "tweets/params[:id]/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect :"tweets/#{@tweet.id}"
    end
  end

end
