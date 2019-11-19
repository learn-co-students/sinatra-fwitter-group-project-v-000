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
   if params[:content] == ""
     redirect :'/tweets/new'
   else
     @user = User.find(session[:user_id])
     @tweet = Tweet.create(content: params[:content], user: @user)
     redirect :'/tweets'
   end
 end

 get '/tweets/:id' do
   @tweet = Tweet.find(params[:id])
   erb :'/tweets/show_tweet'
 end

 delete '/tweets/:id' do
   @tweet = Tweet.find(params[:id])
   @tweet.delete
   redirect '/tweets'
 end

 patch '/tweets/:id' do
   @tweet = Tweet.find(params[:id])
   @tweet.content = params[:content]
   @tweet.save
   redirect "/tweets/#{@tweet.id}"
 end
end
