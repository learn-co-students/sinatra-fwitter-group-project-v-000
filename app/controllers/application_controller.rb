require './config/environment'
# This ApplicationController will contain routes for homepage, login and signup pages.
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'bacon'
  end

# This controller may be overloaded.
# Move All this to users_controller.
# Need helper method to validate whether a user is logged in?

  get '/' do
    erb :'/index'
  end

  #loads the signup page
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    erb :'/u'
  end

end