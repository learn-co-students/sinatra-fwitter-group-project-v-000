class TweetsController < ApplicationController

  get '/tweets' do
    # binding.pry
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = Tweet.new(content: params[:content], user_id: current_user.id)

      @tweet.save
      erb :"/tweets/show_tweet"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if !params[:content].empty? && current_user.id == @tweet.user_id
        @tweet.update(params[:content])
        erb :'/tweets/show_tweet'
      else
        redirect "/tweets/#{params[:id]}/edit"
      end
    else
      redirect 'login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do

  end

  # get '/tweets' do
  # end


end
