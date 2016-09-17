class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?(session)
      @user = User.find_by_id(session[:session_id])
      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?(session)
      @user = User.find_by_id(session[:session_id])
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if params[:content] != nil && params[:content] != ""
      user = User.find_by(:id => session[:session_id])
      if current_user(session).id == user.id
        tweet = Tweet.create(:content => params[:content], :user_id => user.id)
        redirect "/tweets"
      end
    else
      erb :"tweets/new"
    end
  end

end
