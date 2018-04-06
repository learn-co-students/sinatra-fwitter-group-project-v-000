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

 patch '/tweets/:id' do
   if !params["content"].empty?
     @tweet = Tweet.find_by_id(params[:id])
     @tweet.update(:content =>params["content"])
     @tweet.save
   else
     redirect to "/tweets/'#{@tweet.id}'/edit"
   end
 end

 get '/tweets/new' do
   if Helpers.is_logged_in?(session)
     erb :'tweets/create_tweet'
   else
     redirect to '/login'
  end
 end

 get '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
    if Helpers.is_logged_in?(session)
      erb :'tweets/edit_tweet'
    else
      edirect to '/login'
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
   if Helpers.is_logged_in?(session)
     @tweet = Tweet.find_by_id(params[:id])
     erb :'tweets/show_tweet'
   else
    redirect to '/login'
  end
 end





end
