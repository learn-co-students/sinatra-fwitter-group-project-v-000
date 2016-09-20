class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?(session)
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      @user = User.find_by_id(session[:user_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != nil && params[:content] != ""
      tweet = Tweet.create(:content => params[:content], :user => current_user(session))
      redirect "/tweets"
    else
      erb :"tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?(session)
      @tweet = Tweet.find_by(:id => params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?(session)
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user == current_user(session)
        erb :"tweets/edit"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    if logged_in?(session)
      if !params[:content].blank?
        tweet = Tweet.find_by(:id => params[:id])
        tweet.update(:content => params[:content])
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id' do
    if logged_in?(session)
      tweet = Tweet.find_by(:id => params[:id])
      if tweet.user == current_user(session)
        tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    end
  end

end
