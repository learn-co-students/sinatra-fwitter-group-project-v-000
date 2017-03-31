require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/users/signup' do
    erb :'/users/create_user'
  end

  post '/users/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    user.save ? redirect to "/users/#{@user.slug}/tweets"
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/login' do
    erb :'/users/tweets'
  end


end
