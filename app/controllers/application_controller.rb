require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::ActiveRecordExtension
    set :session_secret, "my_application_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  ##### controller actions for users  ----> or add separate controller
  get '/' do

    erb :index
  end
#
#   get '/tweets' do
#
#
#   end
  get '/signup' do
# # binding.pry
# #     if session[:id]
# #
# #       redirect to '/tweets/tweets'
# #     else
      erb :'/users/create_user'
# #     end
  end
#
  post '/signup' do
#
#     user = User.new(username: params[:username], email: params[:email], password: params[:password])
#
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
#       user.save
#       session[:id] = user.id
#
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
#   get '/tweets/tweets' do
#     erb :'/tweets/tweets'
#   end




  helpers do
    # def logged_in?(session)
    #   !!session[:user_id]
    # end
    #
    # def self.current_user(session)
    #   User.find(session[:user_id])
    # end

  end

end
