class TweetsController < ApplicationController
   
   get '/tweets' do 
    if is_logged_in?
     @tweets = Tweet.all
     erb :'/tweets/tweets'
    else
    redirect '/login'
    end
  end

  get '/tweets/new' do
   if is_logged_in?
    erb :'/tweets/create_tweet'
   else 
    redirect '/login'
    end
  end

post '/tweets/new' do
   if !params[:content].empty? 
    
     tweet = Tweet.create(content: params[:content])
      current_user.tweets << tweet
    redirect  to "/tweets/#{tweet.id}"
    
   else
  
     redirect "/tweets/new"
   
   end
  end
  
  get '/tweets/:id' do
    if is_logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
    else
    redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
         erb :'/tweets/edit_tweet'
      
      else
        redirect "/tweets"
      end
    else 
       redirect "/login"
     end
    
  end

  patch '/tweets/:id' do
    
     if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params['content']
      @tweet.save
       redirect "/tweets/#{@tweet.id}"
   
    
 end
end

delete '/tweets/:id/delete' do
  if is_logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == session[:user_id]
    @tweet.delete
    erb :'/tweets/show_tweet'
    end
  end
end
end