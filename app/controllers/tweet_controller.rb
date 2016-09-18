class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?(session)
      @user = User.find_by_id(session[:user_id])
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
      user = User.find_by(:id => session[:user_id])
      tweet = Tweet.create(:content => params[:content], :user_id => user.id)
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
      @tweet = Tweet.find_by(:id => params[:id])
      erb :"tweets/edit"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id/edit' do
    if params[:content] != nil && params[:content] != ""
      tweet = Tweet.find_by(:id => params[:id])
      binding.pry
      tweet = Tweet.update(:content => params[:content])
      redirect "/tweets"
    end
  end

  delete '/tweets/:id' do
    if logged_in?(session)
      tweet = Tweet.find_by(:id => params[:id])
      if params[:id].to_i == session[:user_id]
        tweet = Tweet.delete(params[:id])
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    end
  end

end
