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
      redirect to "/tweets/index"
    end
  end
  
  get "/login" do
    erb :login
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
     session[:user_id] = @user.id
      redirect to "/tweets/index"
    else
      redirect to "/signup"
    end
  end
  
  get '/tweets/index' do
     erb :'/tweets/index'
  end
  
  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/login"
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
