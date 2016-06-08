class TweetsController < ApplicationController

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end   
  end

  get '/tweets/new' do
    if session[:user_id]
      erb :'tweets/create_tweet'
    else
      redirect to '/users/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do 
    if session[:user_id]
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect to '/users/login'
    end
  end

  get '/tweets/:id/edit' do
    if session[:user_id] 
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do 
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
     redirect to "/tweets/#{params[:id]}/edit"
    end
  end

end