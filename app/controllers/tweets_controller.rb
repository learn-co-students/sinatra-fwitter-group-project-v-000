class TweetsController < ApplicationController

  get '/tweets' do
    if !!session[:id]
      @user = User.find(session[:id])
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if !session[:id]
      redirect to "/login"
    else
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    if params.has_value?("")
      redirect to "/tweets/new"
    else
      @user = User.find(session[:id])
      @tweet = Tweet.create(params)
      @user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !!session[:id]
      @user = User.find(session[:id])
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do 
    if !!session[:id]
      @user = User.find(session[:id])
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params.has_value?("")
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save 
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    if !!session[:id]
      @tweet = Tweet.find_by(params[:id])
      @tweet.destroy
    else
      redirect to "/login"
    end
  end

end