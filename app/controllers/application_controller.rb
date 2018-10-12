require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  end

  get '/' do
    @tweets = Tweet.all

    erb :index
  end

  get '/signup' do
    erb :'/users/create_user'
  end
  

  get '/logout' do
    @status = Helpers.is_logged_in?(session)
    
    if @status == true
        session.clear
        redirect '/login'
    else 
        flash[:message] = "You cannot log out if you weren't ever logged in!" 
        redirect '/'
    end
  end

  class Helpers
    def self.current_user(session)
      @user = User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
      !!session[:user_id] ? true : false
    end
  end
end
