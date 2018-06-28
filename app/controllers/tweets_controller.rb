class TweetsController < ApplicationController

  get '/tweets/new' do 
    erb :'/tweets/new'
  end
  
  get '/tweets' do 
    @tweets = Tweet.all
    erb :'/tweets/index'
  end
  
  post '/tweets' do 
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    redirect to "/tweets/#{@tweet.id}"
  end
  
  get '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
  
  get '/tweets/:id/edit' do 
    tweet = Tweet.find(params[:id])
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
    end
    if @user.tweets.include?(tweet)
        @tweet = tweet
     erb :'/tweets/edit'
    else 
      flash[:message] = "You may not edit another user's tweet."
     redirect to '/tweets'
    end
    
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
  end
  
  delete '/tweets/:id/delete' do 
	   tweet = Tweet.find(params[:id])
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
    end
    if @user.tweets.include?(tweet)
        @tweet = tweet
        @tweet.delete
     redirect to '/tweets'
    else 
      flash[:message] = "You may not edit another user's tweet."
     redirect to '/tweets'
    end
	end

  

end
