require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    enable :sessions
    set :session_secret, "my_application_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

get '/' do
  erb :index
end

def self.current_user(session)
current_user = User.find(session[:user_id])
current_user
end

def self.is_logged_in?(session)
if session[:user_id] != nil
  true
else
  false
end
end

end
