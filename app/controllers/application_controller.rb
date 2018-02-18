
require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base



  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end


  get "/" do
    erb :index
  end

  helpers do

    #memoizing a call is using the conditional assignment operator ||=
    #Because current_user  is called multiple times, Its better to only hit the database once and then 'cache' the user instance into an instance variable
    def current_user
       @current_user ||= User.find(session[:id]) if session[:id]
    end

    def logged_in?
      !!current_user
    end
    
  end



end


#rspec ./spec/controllers/application_controller_spec.rb --fail-fast
