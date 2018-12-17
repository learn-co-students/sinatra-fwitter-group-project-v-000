class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])

      if current_user.tweets.include?(@tweet)
        erb :'/tweets/edit_tweets'
      else
        redirect '/tweets'
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params[:content] != ""
      @tweet = Tweet.find_by(params[:id])
      @tweet.update(:content => params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
