class TweetsController < ApplicationController
  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    redirect to '/tweets'
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    redirect to '/tweets/1'
  end

  delete '/tweets/:id/delete' do
    redirect to '/tweets'
  end
end
