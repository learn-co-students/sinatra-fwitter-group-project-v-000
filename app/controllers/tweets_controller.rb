class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    erb :show
  end

  get '/tweets/:id' do
    binding.pry
    erb :'/tweets/create_tweet'
  end

  get '/tweets/new' do 
    binding.pry
  end

  post '/tweets/new' do 
    @tweet = Tweet.create(content: params[:content])
    binding.pry
  end

end