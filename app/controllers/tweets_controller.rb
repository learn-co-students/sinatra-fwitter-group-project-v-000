class TweetsController < ApplicationController

  get '/tweets' do
    redirect to '/login' if !logged_in?
    erb :'tweets/tweets'
  end

end
