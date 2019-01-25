require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'


class ApplicationController < Sinatra::Base
  enable :sessions
  register Sinatra::Flash


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/' do
    "Welcome to Fwitter"
  end

end
