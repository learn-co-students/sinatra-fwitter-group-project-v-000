require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
  end

  ##### controller actions for users  ----> or add separate controller
  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?(session)
      erb :'/users/create_user'
    else
      redirect to '/tweets/tweets'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      user.save
      session[:id] = user.id
      redirect to '/tweets/tweets'
    end
    redirect to '/users/signup'
  end
#
#   get '/login' do
#     erb :'/users/login'
#   end
#
#   post '/login' do
#     user = User.find_by(username: params[:username])
#     if user && user.authenticate(params[:password])
#       session[:id] = user.id
#     redirect to '/tweets/tweets'
#     end
#     redirect to '/signup'
#   end
#    #### controller actions for tweets ----> or add separate controller
#
  get '/tweets/tweets' do
    erb :'/tweets/tweets'
  end




  helpers do
    def logged_in?(session)
      !!session[:id]
    end

    def self.current_user(session)
      User.find(session[:id])
    end

  end

end
