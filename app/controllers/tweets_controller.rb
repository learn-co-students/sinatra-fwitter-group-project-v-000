class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do

    erb :'/tweets/new'
  end

  post '/tweets' do

    redirect to '/tweets'
  end

  get '/tweets/:id' do

    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  patch '/tweets/:id' do

    redirect to '/tweets/:id'
  end

  post '/tweets/:id/delete' do

    redirect to '/tweets'
  end

end
