class TweetsController < ApplicationController

  get '/tweets' do
    if !session[:user_id]
      redirect to '/login'
    else
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if !session[:user_id]
      redirect to '/login'
    else
    erb :'/tweets/new'
  end
end

  post '/tweets' do
    if params[:content].empty? || !session[:user_id]
      redirect to '/tweets/new'
    else
    @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
    erb :'/tweets/show'
    end
  end

  get '/tweets/:id' do
    if !session[:user_id]
      redirect to '/login'
    else
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show'
  end
end

  get '/tweets/:id/edit' do
      if !session[:user_id]
      redirect to '/login'
      else
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content].empty? || !session[:user_id]
      redirect to "/tweets/#{@tweet.id}/edit"
    else
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end
end

  delete '/tweets/:id' do
    @user = User.find_by(session[:user_id])
    @tweet = Tweet.find(params[:id])
    if session[:user_id] && @user.tweets.include?(@tweet)
    @tweet.destroy
  else
    puts "Sorry, cannot delete tweet!"
  end
  end


end
