require './config/environment'
# require './app/models/user'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "password_security"
  end

#--- Main Fwitter homepage ---
  get '/' do
    erb :'/index'
  end

#--- Tweet Homepage ---

  get '/tweets' do
    # @user = current_user
    erb :'/tweets/tweets'
  end

#--- signup ---
  get '/signup' do
    if !logged_in #user can't view signup page in logged_in
      erb :'users/signup'
    else
      redirect "/tweets"
    end
  end

  post '/signup' do
    if params.has_value?("")
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

#--- login ---
  get '/login' do
    # binding.pry
    if !logged_in #user can't view login page in logged_in
      erb :'/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    binding.pry
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

#--- logout ---
  # get '/logout' do
  #   if !logged_in
  #     #don't load /tweets
  #     redirect "/"
  #   else
  #     # session.clear
  #     redirect "/login"
  #   end
  # end

#--- user show page ---

  # get '/users/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :'/users/show'
  # end

#--- index action ---




#--- show action ---




#--- edit action ---



#--- delete action ---





#--- helper methods ---
  def current_user
    User.find_by(session[:user_id])
  end

  def logged_in
    !!session[:user_id]
  end



    # get '/tweets/new' do
    #   erb :"tweets/:slug"
    # end
    #
    # get '/tweets/:slug' do
    #   if logged_in?
    #     redirect to '/tweets/new'
    #   end
    # end
    #
    # post '/tweets/:slug' do
    #
    # end

end
