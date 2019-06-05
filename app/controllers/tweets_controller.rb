class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'tweets/new'
  end

end
