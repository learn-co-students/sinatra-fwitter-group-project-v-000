class TweetsController < ApplicationController

  get '/tweets' do
    erb :'/twitter/index'
  end

end
