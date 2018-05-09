require './config/environment'

class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
end


end
