require './config/environment'
require './app/models/users'

class ApplicationController < Sinatra::Base
register Sinatra::ActiveRecordExtension
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if current_user(session).nil?
      erb :signup
    else
      redirect '/tweet_controller/tweets'
    end
  end

  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    user.id = session[:session_id]
    redirect "p/tweets"
  end

  helpers do
    def current_user(session)
      user = User.find_by_id(session[:session_id])
    end

    def is_logged_in?(session)
      !!current_user(session)
    end
  end
end
