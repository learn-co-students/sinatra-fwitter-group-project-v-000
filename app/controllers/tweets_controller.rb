class TweetsController < ApplicationController
   
   get '/tweets' do 
    if is_logged_in?
    
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
      @tweet = current_user.tweets.create(content: params[:content])
      redirect  to "/tweets/#{@tweet.id}"
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
      @tweet = Tweet.find(params[:id])
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
  
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id == @tweet.user_id
    @tweet.delete
    
    redirect to "/tweets"
  else
    redirect to "/tweets"
  end
end
end