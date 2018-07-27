class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to ("/login")
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to ("/login")
    end
  end

  post '/tweets' do
    if logged_in? && !params[:content].empty?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      @tweet.save
      redirect to ("/tweets/#{@tweet.id}")
    else
      redirect to ("/tweets/new")
    end
  end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet && @tweet.user == current_user
      erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if !params[:content].empty?
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
   if logged_in?
     @tweet = Tweet.find(params[:id])
     if @tweet && @tweet.user == current_user
       @tweet.destroy
       redirect to ("/users/#{current_user.id}")
     else
       redirect to '/tweets'
     end
   else
     redirect to '/login'
   end
 end


end
