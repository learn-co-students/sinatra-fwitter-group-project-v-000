class TweetsController < ApplicationController

  get '/tweets' do
    erb :index
  end

end
