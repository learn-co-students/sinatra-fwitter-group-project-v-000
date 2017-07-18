require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    register Sinatra::Twitter::Bootstrap::Assets
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :home
  end

end
