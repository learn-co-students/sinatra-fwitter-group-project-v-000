require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

    erb :"/homepage"
  end
  get '/signup' do
    @user = User.all
    erb :"/signup"
  end

  post '/signup' do
    puts params
    @users = User.create(params[:user])
    @users.save
    session[:id]
    redirect to "/tweets/index"
  end

  get '/sessions/login' do
    puts "hello world"

    erb :"/sessions/login"
    end
end