class TweetsController < ApplicationController

  get '/tweets' do
   if logged_in?
     @tweets = Tweet.all
     erb :'tweets/index'
   else
     redirect to '/login'
   end
  end

 get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
 end

 post "/tweets" do
   if params["content"].empty?

     redirect to "/tweets/new"
   end
   @tweet = Tweet.new(content: params["content"], user_id:current_user.id)
   @tweet.save
   redirect to "/tweets/#{@tweet.id}"
 end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user_id == current_user.id
         erb :'tweets/edit'
      else
         redirect to '/login'
      end
  end

  patch "/tweets/:id" do
    if params["content"].empty?

      redirect to "/tweets/#{params[:id]}/edit"
    end
    @tweet = Tweet.find(params[:id])
    if @tweet && (@tweet.user_id == current_user.id)
      @tweet.update(content: params["content"])
      @tweet.save
      redirect to "/tweets"
    end
  end

  delete '/tweets/:id/delete' do
   if logged_in?
     @tweet = Tweet.find_by_id(params[:id])
     if @tweet.user_id == current_user.id
       @tweet.delete
       redirect to '/tweets'
     else
       redirect to '/tweets'
     end
   else
     redirect to '/login'
   end
 end
end
