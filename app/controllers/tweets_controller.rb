class TweetsController < ApplicationController

  get '/tweets/new' do 
    erb :'/tweets/new'
  end
  
  post '/tweets' do 
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    redirect to "/tweets/#{@tweet.id}"
  end
  
  get '/tweets/:id' do 
    @tweet = Tweet.find_by(user_id: session[:id])
    erb :'/tweets/show'
  end
  
  get '/tweets/:id/edit' do 
    
    erb :'/tweets/edit'
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:id]
      @tweet.update(params[:content])
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else 
      redirect '/login'
    end
  end
  

end
