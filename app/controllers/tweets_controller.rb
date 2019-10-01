class TweetsController < ApplicationController

  get "/tweets" do 
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else 
      redirect '/users/login'
    end
  end
  
  get "/tweets/new" do
    if logged_in?
      erb :'/tweets/new' 
    else 
      redirect "/users/login"
    end
  end
  
  post "/tweets" do 
    if params[:content] == ""
      redirect "/tweets/new"
    else
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  get "/tweets/:id" do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet" 
    else 
      redirect "/login" 
    end
  end
  
  get "/tweets/:id/edit" do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id]) 
      if @tweet && (@tweet.user_id == current_user.id)
        
       erb :"/tweets/edit_tweet" 
      else
        redirect "/tweets"
      end
    else
      redirect "users/login"
    end
  end 
  
  
  
 
  
    

end
