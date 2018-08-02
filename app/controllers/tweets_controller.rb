class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets' do
    if session["user_id"] == current_user.id
      @user = User.find(current_user.id)
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #
    # erb :'/show'
  end

  get '/tweets/:id' do

  end

  get '/tweets/:id/edit' do

  end

  patch '/tweets/:id' do

  end

  delete 'tweets/:id' do

  end

end # TweetsController
