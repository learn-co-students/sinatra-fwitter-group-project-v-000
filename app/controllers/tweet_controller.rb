class TweetController < ApplicationController
  configure do
    set :views, '/app/views/tweets'
  end

  get '/' do
    erb :index
  end

  get '/tweets/new' do
    erb :new
  end

  post '/tweets' do
    erb :show
  end
end
