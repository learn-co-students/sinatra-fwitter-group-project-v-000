class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    if @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect "tweets/new"
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show"
  end

  post 'tweets/:id/delete' do
    Tweet.destroy(params[:id])
  end
    

end
