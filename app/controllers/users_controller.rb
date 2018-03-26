class UsersController < ApplicationController
#=======================================signup========================================= 
  get '/signup' do 
    if !logged_in? then erb :"users/create_user" else redirect '/tweets' end
  end
#-------------------------------------------------------------------------------------- 
  post '/signup' do 
    redirect '/signup' if empty?(params)
    
    user = User.create(params)
    set_session(user.id)
    
    redirect '/tweets' if logged_in?
  end
#=======================================login========================================== 
  get '/login' do 
    if !logged_in? then erb :'users/login' else redirect '/tweets' end
  end
#-------------------------------------------------------------------------------------- 
  post '/login' do 
    user = User.find_by(username: params[:username])
    
    set_session(user.id) and redirect '/tweets' if authentic?(user, params[:password])
    
    redirect to '/signup'
  end
#======================================logout========================================== 
  get '/logout' do 
    session.clear and redirect '/login' if logged_in?
    
    redirect to '/'
  end
#=======================================show=========================================== 
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    
    erb :'users/show'
  end
#====================================================================================== 
end



