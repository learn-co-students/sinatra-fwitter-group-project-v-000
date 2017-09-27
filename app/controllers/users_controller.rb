# must inherit from ApplicationController not Sinatra::Base
class UsersController < ApplicationController
  # SAMPLE USERS: test => test (pwdord), online_t => passwaord (NOT pword)

  get '/signup' do
    logged_in? ? (redirect '/tweets') : (erb :'users/create_user')

    # if !logged_in?
    #   erb :'users/create_user'
    # else
    #   redirect '/tweets'
    # end
  end

  post '/signup' do
    if  params[:username].empty? || params[:email].empty? ||
        params[:password].empty?
      redirect '/signup'
    else
      user = User.create(username: params[:username], email: params[:email],
             password: params[:password])

      session[:user_id] = user.id

      redirect '/tweets'
    end
  end

  get '/login' do
    logged_in? ? (redirect '/tweets') : (erb :'users/login')
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    # if the user is loged-in then they can log out & b redirected 2 login pg,
      # else it goes 2 the hmpg, where the user can choose 2 signup/login
    logged_in? ? session.clear && (redirect '/login') : (redirect '/')
  end

end
