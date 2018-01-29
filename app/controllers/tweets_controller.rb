class TweetsController < ApplicationController

  get "/tweets" do
    if logged_in?
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    @tweet = Tweet.new(content: params[:content])
    @tweet.user = @user
    @user.save
    redirect "users/#{@user.slug}"

    #must fix this action, use pry to inspect what is going on

  end

end
