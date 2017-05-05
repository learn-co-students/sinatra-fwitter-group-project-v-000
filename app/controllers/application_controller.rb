require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :home
  end

  get '/singup' do
    erb :singup
  end

  get '/login' do
    erb :login
  end

  get '/failure' do
    erb :failure
  end

  post '/singup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      redirect to ""
    else
      redirect to "/failure"
  end

end
