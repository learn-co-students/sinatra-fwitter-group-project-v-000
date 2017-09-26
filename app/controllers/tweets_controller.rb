class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/index"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

#if content is blank, directs user to create new tweet. otherwise posts the new tweet.
  post '/tweets' do
    @tweet = current_user.tweets.create(content: params[:content])
     if @tweet.save
       redirect to "/tweets/#{@tweet.id}"
     else
       redirect "/tweets/new"
     end
   end

   get '/tweets/:id' do
     if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
       erb :'/tweets/show'
     else
       redirect '/login'
     end
   end

   get '/tweets/:id/edit' do
     if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit'
       else
         redirect to '/login'
     end
   end

   patch '/tweets/:id' do
     if params[:content] == ""
       redirect to "/tweets/#{params[:id]}/edit"
     else
       @tweet = Tweet.find_by_id(params[:id])
       @tweet.content = params[:content]
       @tweet.save
       redirect to "/tweets/#{@tweet.id}"
     end
   end

   delete '/tweets/:id/delete' do
     if logged_in?
       @tweet = Tweet.find_by_id(params[:id])
       if @tweet.user_id == current_user.id
         @tweet.delete
         redirect to '/tweets'
       end
       else
         redirect to '/login'
       end
   end
 end
