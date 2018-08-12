class TweetsController < ApplicationController

  get '/tweets' do
    redirect_if_not_logged_in(session)
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    redirect_if_not_logged_in(session)
    @user = User.find(session[:user_id])
    erb :'tweets/new'
  end

  get '/tweets/:id/edit' do
    redirect_if_not_logged_in(session)
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/edit'
  end

  get '/tweets/:id' do
    redirect_if_not_logged_in(session)
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show'
  end

  post '/tweets' do
    tweet = Tweet.new(params)
    tweet.user = current_user(session)
    
    if !tweet.save
      redirect to "/tweets/new"
    else
      tweet.save
      redirect to "/tweets/#{tweet.id}"
    end
  end

  patch '/tweets/:id' do
    redirect_if_not_logged_in(session)
    tweet = Tweet.find_by(id: params[:id]) 
    if tweet.update(content: params[:content])
      tweet.update(content: params[:content])
      redirect to "/tweets/#{tweet.id}"
    else
      redirect to "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    redirect_if_not_logged_in(session)
    if current_user(session) != Tweet.find(params[:id]).user
      redirect to '/tweets'
    end
    Tweet.delete(params[:id])
    redirect to '/tweets'
  end

end
