class TweetsController < ApplicationController

 get '/tweets' do
   if logged_in?
     @tweets = Tweet.all
     erb :'/tweets/index'
   else
     redirect '/login'
   end
 end

 get '/tweets/new' do
   if logged_in?
     erb :'/tweets/new'
   else
     redirect '/login'
   end
 end

 post '/tweets/new' do
   if logged_in?
    if params["content"].empty?
      redirect '/tweets/new'
    else
      current_user.tweets << @tweet = Tweet.create(params)
      current_user.save
      redirect "/tweets/#{@tweet.id}"
    end
  else
    redirect '/login'
  end
 end

 get '/tweets/:id' do
   if logged_in?
     @tweet = Tweet.find(params["id"])
     erb :'/tweets/show'
   else
     redirect '/login'
   end
 end

 get '/tweets/:id/edit' do
   if logged_in?
     @tweet = Tweet.find(params["id"])
     if @tweet && @tweet.user == current_user
       erb :'/tweets/edit'
     else
       redirect '/tweets'
     end
   else
     redirect '/login'
   end
 end

patch '/tweets/:id/edit' do
  if logged_in?
    @tweet = Tweet.find_by_id(params["id"])
    if params["content"].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      if @tweet && @tweet.user == current_user
        @tweet.content = params["content"]
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets'
      end
    end
  else
    redirect '/login'
  end
 end

 delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end
