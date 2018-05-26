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
     @tweet = Tweet.find(params[:id])
   if !params["content"].empty?
     @tweet.update(:content =>params["content"])
    #  @tweet.save
     erb :'tweets/show_tweet'
   else
     redirect to "/tweets/#{@tweet.id}/edit"
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
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

 post '/tweets' do
   if !params["content"].empty?
     @tweet = Tweet.new(params)
     @tweet.user_id = session["user_id"]
     @tweet.save
     redirect to '/tweets'
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

 delete '/tweets/:id' do
   @tweet = Tweet.find_by_id(params[:id])
   if @tweet.user_id == session["user_id"]
     @tweet = Tweet.delete(params[:id])
     redirect to '/tweets'
  else
    redirect to '/tweets'
  end
 end



end
