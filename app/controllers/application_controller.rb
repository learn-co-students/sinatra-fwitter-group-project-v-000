# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

# SENDS signup form
  get '/registration/signup' do
    erb :signup
  end

# POSTS sign up form and CREATES user
  post '/registration/signup' do
    @user = User.create(name: params[:username], email: params[:email], password: params[:password])
    session[:id] = @user.id
    redirect to erb :"/twitter/index"
  end
end



  	#put login/logout in this controller?

#   	  post '/login' do
#   	    @user = User.find_by(:username => params[:username])
#
#   	    if @user != nil && @user.password == params[:password]
#   	      session[:user_id] = @user.id
#   	      redirect to '/account'
#   	      end
#   	      erb :error
#   	  end
#
#   	  get '/account' do
#   	    @current_user = User.find_by_id(session[:user_id])
#   	    if @current_user
#   	        erb :account
#   	    else
#   	      erb :error
#   	    end
#   	  end
#
#   	  get '/logout' do
#   	    session.clear
#   	    redirect to '/'
#   	  end
#   helpers do
#     def logged_in?
#       !!current_user
#         # because of return value/boolean
#     end
#     def current_user
#       @current_user ||= User.find_by(id: session[user_id]) if session[:user_id]
#     end
#   end
# # these two are formulaic
#
# end
#
# ***
#
#   get '/registrations/signup' do
#     erb :'/registrations/signup'
#   end
#
#   post '/registrations' do
#     puts params
#     @user = User.new(name: params["name"], email: params["email"], password: params[:password])
#     @user.save
#     session[:id] = @user.id
#
#     #user info into params hash, create new user, sign them in, redicret
#     redirect '/users/home'
#   end
#
# #render login form
#   get '/sessions/login' do
#     erb :'sessions/login'
#   end
#
#   post '/sessions' do
#     #receive Post request, code to grab users info from params hash, match that info against the etnries in db, and if ===, sign in user
#     @user = User.find_by(email: params["email"], password: params[:password])
#     session[:id] = @user.id
#     redirect '/users/home'
#   end
#
#   get '/sessions/logout' do
#     #clear the session
#     session.clear
#     redirect '/'
#   end
#
#   get '/users/home' do
#    #render user's homepage view
#    @user = User.find(session[:id])
#     erb :'/users/home'
#   end
