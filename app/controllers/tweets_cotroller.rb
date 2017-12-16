class TweetsController < ApplicationController

  get '/tweets' do    
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    redirect :'/tweets/:id'
  end

  get '/tweets/:id' do
    erb :'/tweets/show_tweet'
  end

end
