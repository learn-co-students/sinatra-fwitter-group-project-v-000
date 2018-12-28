class TweetsController < ApplicationController

  get '/tweets' do
    if current_user && is_logged_in?
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end
  
  get "/tweets/:id" do
    if is_logged_in? 
      @tweet = Tweet.find_by_id(params["id"])
      erb :'/tweets/show_tweet'
    else 
      redirect to "/login"
    end 
  end 
  
  get "/tweets/:id/edit" do 
    if is_logged_in? 
      @tweet = Tweet.find_by_id(params["id"])
      erb :'/tweets/edit_tweet'
    else 
      redirect to "/login"
    end 
  end 
  
  delete "/tweets/:id/delete" do 
    @tweet = Tweet.find_by_id(params["id"])
    if is_logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
    else 
      redirect to '/login'
    end 
  end 
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params["id"])
    if !params["content"].empty?
      @tweet.content = params["content"]
      @tweet.save
    else 
      redirect to "/tweets/#{@tweet.id}/edit"
    end 
  end 
 
  post '/tweets' do
    if !params["content"].empty? 
      @tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
    else 
      redirect to "/tweets/new"
    end
  end 
  
end
