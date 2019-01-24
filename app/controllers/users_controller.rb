use Rack::MethodOverride
class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
      @user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
     end
   end

  get '/login' do
    if !logged_in?
      erb :login
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user == nil
      redirect '/login'

    else @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end


  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/tweets/tweet'
      end

end
