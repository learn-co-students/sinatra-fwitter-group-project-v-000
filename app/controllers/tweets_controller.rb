class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      current_user.add_tweet(@tweet)
      redirect '/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      if current_user == @tweet.user
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      if @tweet.user == current_user
        erb :'tweets/edit'
      else
        redirect '/login'
      end
    else redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      redirect "/tweets/#{params[:id]}/edit" if params[:content] == ""
      @tweet = Tweet.find_by(:id => params[:id])
      if @tweet.user == current_user
        @tweet.update(:content => params[:content])
        redirect "/tweets/#{params[:id]}"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
