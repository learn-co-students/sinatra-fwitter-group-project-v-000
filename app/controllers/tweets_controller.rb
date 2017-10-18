class TweetsController < ApplicationController

  get '/tweets' do
    @user = current_user
    if logged_in?
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
