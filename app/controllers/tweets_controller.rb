class TweetsController < ApplicationController

  get '/tweet/new' do
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/create_tweet"
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  get 'tweets/:id' do
    @tweet = Tweet.find(session[:user_id])
  end

end
