require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    render :layout => false
  erb :'/layout'
  end

  get '/index' do
  erb :'/index'
  end

end
