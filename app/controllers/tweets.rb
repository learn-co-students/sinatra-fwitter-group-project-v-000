class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content])
    @tweet.user_id = session[:user_id]
    @tweet.save
    # redirect to "/tweets/#{@tweet.id}/show"
    redirect to "/tweets"

  end

  get '/tweets/:id/show' do
    @tweet = Tweet.find(:id)
    erb :'/tweets/show_tweet'
  end

end
