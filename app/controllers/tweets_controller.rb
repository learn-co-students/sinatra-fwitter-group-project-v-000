class TweetsController < ApplicationController
   get '/tweets' do
      logged_in? ? (erb :'tweets/tweets') : (redirect '/login')
   end

   get '/tweets/new' do
      logged_in? ? (erb :'tweets/create_tweet') : (redirect '/login')
   end

   post '/tweets/new' do
      if params[:content].empty?
         redirect '/tweets/new'
      else
         Tweet.create(content: params[:content], user_id: current_user.id)
         redirect '/tweets'
      end
   end

   get '/tweets/:id' do
      @tweet = Tweet.find_by(id: params[:id])
      logged_in? ? (erb :'tweets/show_tweet') : (redirect '/login')
   end

   get '/tweets/:id/edit' do
      if logged_in?
         @tweet = Tweet.find_by(id: params[:id])
         @tweet.user.id == current_user.id ? (erb :'tweets/edit_tweet') : (redirect '/tweets')
      else
         redirect '/login'
      end
   end

   patch '/tweets/:id/edit' do
      @tweet = Tweet.find_by(id: params[:id])
      if params[:content].empty?
         redirect "/tweets/#{@tweet.id}/edit"
      else
         @tweet.content = params[:content]
         @tweet.save
         redirect '/tweets'
      end
   end

   delete '/tweets/:id/delete' do
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user.id == current_user.id
         @tweet.destroy
         @tweet.save
         redirect '/tweets'
      else
         redirect '/tweets'
      end
   end
end
