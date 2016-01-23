require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  include Helpers
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	#binding.pry  
  	erb :index
  end

end