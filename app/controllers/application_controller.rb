require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "arcticmonkeys"
  end

  get '/' do
    erb :index
  end

  post '/signup' do
    @user = User.create(params)
    @session = session
    @session[:id] = @user.id
    if is_logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/users/login'
    end
  end

  get '/signup' do
    @session = session
    if is_logged_in?
      erb :'tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  helpers do
    def is_logged_in?
      @session = session
      @session.has_key?(:id) ? true : false
    end

    def current_user
      @session = session
      User.find_by_id(@session[:id])
    end
  end

end