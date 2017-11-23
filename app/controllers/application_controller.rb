require './config/environment'

class ApplicationController < Sinatra::Base

  include Helper

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

end
