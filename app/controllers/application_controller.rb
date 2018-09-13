require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/index'
  end

get '/users/' do
  erb :'users/'
end

  post '/users' do
    @user = User.create(params[:params])
    @user.username = params[:username]
    @user.email = params [:email]
    @user.password = params[:password]


    redirect "users/#{@user.id}"
  end


end
