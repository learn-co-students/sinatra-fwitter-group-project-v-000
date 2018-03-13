class TweetsController < ApplicationController
  use Rack::Flash


  get '/tweets' do

    erb :'tweets/tweets'
  end


end
