class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if Helpers.is_logged_in?(session)
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    binding.pry
  end

end
