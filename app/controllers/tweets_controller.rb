class TweetsController < ApplicationController

  get '/tweets/:id' do
    binding.pry
    # @tweets = Tweet.all
    erb :'tweets/index'
  end

  post '/tweets/:id' do
    binding.pry
  end

end
