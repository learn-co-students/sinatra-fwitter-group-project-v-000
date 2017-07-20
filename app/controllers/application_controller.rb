require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, 'secret string'

    use Rack::Flash
  end

  helpers LoginUtils


  get '/' do
    erb :index
  end


  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    login(params)
  end

  get '/logout' do
    if logged_in?
      logout
      redirect '/login'
    else
      redirect '/'
    end
  end

end