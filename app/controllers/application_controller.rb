require './config/environment'
require "sinatra/reloader"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Reloader
    enable :reloader
  end

  get '/' do
    erb :homepage
  end

end