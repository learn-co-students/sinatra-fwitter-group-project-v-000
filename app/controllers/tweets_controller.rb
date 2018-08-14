class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

   get '/tweets' do
     if logged_in?
       @user = current_user
       @tweets = Tweet.all
       erb :'/tweets/tweets'
     else
       redirect '/login'
     end
   end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in?
      if @tweet.user_id == current_user.id
        @user = current_user
        @tweet.delete
        @tweets = Tweet.all
        erb :'/tweets/tweets'
      end
    else
      redirect '/login'
    end

  end

end # TweetsController
