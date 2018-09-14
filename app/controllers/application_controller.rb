require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

  end

  get '/' do
  erb :'/layout'
  end

  get '/index' do
    render :layout => false

  erb :'/index'
  end

end
