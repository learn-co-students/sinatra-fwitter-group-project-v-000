class TweetController < ApplicationController
  configure do
    set :views, '/app/views/tweets'
  end

  get '/tweets' do
    erb :index
  end

#
#  get '/tweets/new' do
#    erb :new
#  end
#
#  get '/:id/tweets' do
#    erb :show
#  end
#
#  post '/tweets' do
#    erb :show
#  end
end
