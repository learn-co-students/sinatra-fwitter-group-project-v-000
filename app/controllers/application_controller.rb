require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'home'
  end

  get '/signup' do
    erb :'/registrations/signup'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      # binding.pry
      redirect '/signup'
    else
      @user = User.create(params)
      # session[:id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    erb :'/users/home'
  end

end
