class TweetsController < ApplicationController
  enable :sessions
  set :session_secret, 'fwitter'
  set :public_folder, 'public'
  set :views, 'app/views'


  get '/tweets' do
    redirect '/' if !logged_in?
    erb :'tweets/tweets'
  end


end
