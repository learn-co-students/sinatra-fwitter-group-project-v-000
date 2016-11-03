class TweetController < ApplicationController

  get '/tweets/new' do
    if !logged_in?
      redirect "/login"
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    if  logged_in?  && params["tweet"] != ""
      @tweet = Tweet.new(:content => params["tweet"])
      @user = User.find(session[:user_id])
      @user.tweets << Tweet.create(:content => params["tweet"])
      @user.save
      redirect '/tweets'
    elsif params["tweet"] == ""
      redirect '/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweet= Tweet.all
      erb :'tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet= Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet= Tweet.find(params[:id])
      if current_user.tweets.include?(@tweet)
        erb :'/tweets/edit_tweet'
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    if params["tweet"] == ""
      @tweet = Tweet.find(params[:id])
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(:content => params["tweet"])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
    @tweet = Tweet.find(params[:id])
      if current_user.tweets.include?(@tweet)
        @tweet.delete
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
