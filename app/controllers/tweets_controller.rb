class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    erb :'tweets/show_tweets'
  end

end
