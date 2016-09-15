require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
      erb :signup
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      redirect "/tweet_controller/signup/tweets"
    else
      redirect '/failure'
    end
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
