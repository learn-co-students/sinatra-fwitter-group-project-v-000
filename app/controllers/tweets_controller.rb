class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :"/tweets/tweets"
    else 
       redirect "/login"
    end 
  end

   get '/tweets/new' do
     #binding.pry
     if logged_in?
       erb :'/tweets/new'
     else
       redirect "/login"
     end
   end
  
  post '/tweets' do 
    if params[:content] != ""
      @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
      redirect "/tweets/#{@tweet.id}"
    else 
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else 
      redirect "/login"
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else 
      redirect "/login"
    end
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id && params[:content] != "" && logged_in?
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    elsif 
      @tweet.user_id == current_user.id && params[:content] == "" && logged_in?
      redirect "/tweets/#{@tweet.id}/edit"
    else 
      redirect "/tweets"
    end
    
  end 
  
  delete '/tweets/:id/delete' do 
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
      redirect to '/tweets'
    else 
      redirect "/tweets"
    end
  end

end
