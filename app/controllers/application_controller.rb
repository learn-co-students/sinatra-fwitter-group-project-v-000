require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end
  
  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params[:username] == ""  ||  params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      User.create(username: params[:username], email: params[:email], password: params[:password])
      redirect "/tweets/index"
    end
  end
  
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
