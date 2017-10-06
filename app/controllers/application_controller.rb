require './config/environment'

class ApplicationController < Sinatra::Base

  # configure do
  #   set :public_folder, 'public'
  #   set :views, 'app/views'
  # end

  set :views, Proc.new { File.join(root, "../views/") }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :'/users/create_user'
  end





end