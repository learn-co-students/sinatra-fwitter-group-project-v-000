class TweetsController < ApplicationController
#==============================tweets================================ 
  get '/tweets' do 
    redirect '/login' if !logged_in?
    
    erb :"tweets/tweets"
  end
#===============================new================================== 
  get '/tweets/new' do 
    redirect '/login' if !logged_in?
    
    erb :'tweets/create_tweet'
  end
#-------------------------------------------------------------------- 
  post '/tweets' do 
    redirect '/tweets/new' if empty?(params)
    
    Tweet.create(content: params[:content], user_id: current_user.id)
    redirect '/tweets'
  end
#==============================show================================== 
  get '/tweets/:id' do 
    redirect '/login' if !logged_in?
    
    @tweet = tweet(params[:id])
    
    erb :'/tweets/show_tweet'
  end
#==============================edit================================== 
  get '/tweets/:id/edit' do 
    redirect '/login' if !logged_in? 
    
    @tweet = tweet(params[:id])
    
    redirect '/tweets' if @tweet.user_id != current_user.id  
    erb :'/tweets/edit_tweet'
  end
#=============================update================================= 
  patch '/tweets/:id' do 
    @tweet = tweet(params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end
#=============================delete================================= 
  delete '/tweets/:id/delete' do 
    @tweet = tweet(params[:id])
    
    @tweet.destroy! if @tweet.user_id == current_user.id
    redirect '/tweets'
  end
#==================================================================== 
end



