# require './config/environment'

class ApplicationController < Sinatra::Base
  include VerifyUser
  configure do
  	enable :sessions unless test?
  	set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  

  # get '/tweets/tweets' do

  # end

  
end