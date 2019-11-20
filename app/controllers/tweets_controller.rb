class TweetsController < ApplicationController

  get '/tweets' do
    if !Helper.is_logged_in?(session)
      redirect '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !Helper.is_logged_in?(session)
      redirect '/login'
    else
      erb :'/tweets/new'
    end
  end

 post '/tweets' do
   if params[:content] == ""
     redirect '/tweets/new'
   else
     @user = User.find(session[:user_id])
     @tweet = Tweet.create(content: params[:content], user: @user)
     redirect '/tweets'
   end
 end

 get '/tweets/:id' do
   if !Helper.is_logged_in?(session)
     redirect '/login'
   else
     @tweet = Tweet.find(params[:id])
     erb :'/tweets/show_tweet'
   end
 end

 delete '/tweets/:id' do
   @tweet = Tweet.find(params[:id])

   if Helper.is_logged_in?(session) && @tweet.user.id == session[:user_id]
     @tweet.delete
     redirect '/tweets'
   else
     redirect '/login'
   end
 end

 get '/tweets/:id/edit' do
   if !Helper.is_logged_in?(session)
     redirect '/login'
   else
     @tweet = Tweet.find(params[:id])
     erb :'/tweets/edit_tweet'
   end
 end

 patch '/tweets/:id' do

   if params[:content] == ""
     redirect "/tweets/#{params[:id]}/edit"
   end

   @tweet = Tweet.find(params[:id])

   if Helper.is_logged_in?(session) && @tweet.user.id == session[:user_id]
     @tweet.content = params[:content]
     @tweet.save
     redirect "/tweets/#{@tweet.id}"
   else
     redirect '/login'
   end
 end
end
