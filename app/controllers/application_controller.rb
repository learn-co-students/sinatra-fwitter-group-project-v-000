require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end



  # get '/login' do
  #   erb :login
  # end
  #
  # post '/login' do
  #   user = User.find_by(:username => params[:username])
  #   if user && user.authenticate (params[:password])
  #     session[:user_id] = user.id
  #     redirect '/success'
  #   else
  #     redirect '/failure'
  #   end
  # end
  #
  # get '/signup' do
  #   erb :signup
  # end
  #
  # post '/signup' do
  #   user = User.new(:username => params[:username], :password => params[:password])
  #   if user.save
  #     redirect '/login'
  #   else
  #     redirect '/failure'
  #   end
  # end

  # get '/success' do
  #
  # end
  #
  # get '/failure' do
  #
  # end

end
