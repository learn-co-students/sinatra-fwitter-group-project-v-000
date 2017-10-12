require './config/environment'
require 'rack-flash' #just here is fine.

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "password_security" #password_security is arbitrary.
    use Rack::Flash #need for those reason for redirection.
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id:session[:user_id]) if session[:user_id]
      # gives me who the current user is, or goes out and finds him/her as long as a session exists.
    end
  end

  get '/' do
    erb :homepage
  end





































end
