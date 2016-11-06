class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !logged_in?
      redirect '/tweets/new'
    elsif  params[:content].empty? 
      redirect '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end 

  patch '/tweets/:id' do
    if params[:content] == ""
      redirect "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if !logged_in? 
      redirect '/login'
    elsif @tweet.user_id != current_user.id  
      redirect '/tweets'
    else 
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect '/tweets'
    end
  end
end