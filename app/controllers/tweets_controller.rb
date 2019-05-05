class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
    @tweets = Tweet.all
    erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
        if params[:content] == ""
          redirect '/tweets/new'
        else
          tweet = Tweet.create(:content=> params[:content])
          tweet.user_id = current_user.id
          tweet.save
      end
    end

  patch '/tweets/:id/edit' do
    tweet = Tweet.find(params[:id])
    tweet.content = params[:content]
    tweet.save
  end



  delete '/tweets/:id/delete' do
    if logged_in?
    @tweet = Tweet.find_by(params[:id])
    @tweet.delete
    else
      redirect '/login'
    end
    redirect '/tweets'
  end


end
