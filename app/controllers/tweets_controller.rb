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
  
 

end
