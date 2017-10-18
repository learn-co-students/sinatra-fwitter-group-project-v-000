class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
  @tweets = Tweet.find_by_id(params[:id])
  erb :'tweets/show'
  end

end
