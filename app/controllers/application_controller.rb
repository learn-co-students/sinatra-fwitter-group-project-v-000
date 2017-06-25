require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
      erb :index
  end

def current_user
 User.find_by_id(session[:id])
 end

def is_logged_in?
session.has_key?(:id) ? true : false
end
end
