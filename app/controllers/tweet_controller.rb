class TweetController < ApplicationController
  
  get '/tweets' do
    erb :index
  end

  get '/:id' do
    erb :show
  end
end
