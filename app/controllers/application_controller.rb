require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions, 'fwitter'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :'/tweets'
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:username] = @user.id
    redirect '/tweets'
    else
    redirect '/signup'
    end
  end

end
