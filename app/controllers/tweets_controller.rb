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
    if Helpers.is_logged_in?(session)
    @tweet = Tweet.find(params[:id])
    @user = Helpers.current_user(session)
    erb :'/tweets/edit'
   else 
     erb :error
    end
  end
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == session[:id]
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else 
      redirect '/login'
    end
  end
  
  delete '/tweets/:id/delete' do 
	  @tweet = Tweet.find_by_id(params[:id])
	  if @tweet.user_id == session[:id]
	    @tweet.delete
	  redirect to '/tweets'
  	else 
  	  redirect '/login'
	  end
	end

  

end
