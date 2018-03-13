class TweetsController < ApplicationController
  use Rack::Flash


  get '/tweets' do
      if logged_in?
        @tweets = Tweet.all
      erb :'tweets/tweets'
      else
      redirect '/login'
      end
  end


end
