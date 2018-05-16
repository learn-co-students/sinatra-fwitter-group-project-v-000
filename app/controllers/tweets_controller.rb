class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end
 
  post '/tweets/new' do
    if params[:content] == ""
      redirect to '/tweets/new'
    else 
    tweet = Tweet.new(params)
    tweet.user_id = current_user.id
    tweet.save
    redirect to '/tweets'
    end
  end

  get '/tweets/:id'  do
    if logged_in?
    erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit' 
    else
     redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if params[:content] == "" 
      redirect to "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find_by_id(params[:id])
      tweet.content = params[:content]
      tweet.save
      redirect to '/tweets'
    end
  end

  patch '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find_by_id(params[:id])
        if tweet && tweet.user == current_user
          tweet.delete
        end
      redirect to '/tweets'
    else
      redirect to '/login'
    end    
  end

end