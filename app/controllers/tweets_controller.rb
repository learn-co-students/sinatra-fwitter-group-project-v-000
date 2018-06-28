class TweetsController < ApplicationController

  get '/tweets/new' do 
    erb :'/tweets/new'
  end
  
  post '/tweets' do 
    @tweet = Tweet.create(content: params[:content], user_id: session[:id])
    redirect to "/tweets/:id"
  end
  
  get '/tweets/:id' do 
    @tweet = Tweet.find_by(user_id: session[:id])
    erb :'/tweets/show'
  end
  

end
