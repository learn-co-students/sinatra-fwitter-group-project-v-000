class TweetsController < ApplicationController

  get '/test' do
    "how about this one?"
  end

  get '/tweets/new' do
    erb :'tweets/new'
  end

end
