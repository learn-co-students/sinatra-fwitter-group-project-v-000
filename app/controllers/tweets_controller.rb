class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
   session.clear
   redirect to '/login'
 end

 get '/tweets/new' do
   if Helpers.is_logged_in?(session)
     erb :'tweets/create_tweet'
   else
     redirect to '/login'
  end
 end

 post '/tweets' do
   if !params["content"].empty?
     @tweet = Tweet.new(params)
     @tweet.user_id = session["user_id"]
     @tweet.save
  else
    redirect to '/tweets/new'
   end
 end

 get '/tweets/:id' do
   @tweet = Tweet.find_by_id(params[:id])
   erb :'tweets/show_tweet'
 end



end
