class TweetsController < ApplicationController

  get '/tweets' do
    if !Helper.is_logged_in?(session)
      redirect :'/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !Helper.is_logged_in?(session)
      redirect :'/login'
    else
      erb :'/tweets/new'
    end
  end

 post '/tweets' do
   @user = User.find(session[:user_id])
   @tweet = Tweet.create(content: params[:content], user: @user)

   redirect :'/tweets'
 end


end
