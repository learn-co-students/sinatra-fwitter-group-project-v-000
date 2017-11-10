class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if params[:username] == "" || params[:email] == "" || params[:password] == "" #can't this be done by validates_presence_of macro (in 'models') alone?
      redirect '/signup'
    end

    if @user.save
      session[:user_id] = @user.id  #automatically login user on valid save
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/"
    end
  end

   get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
     erb :'/users/show'
   end

    get '/logout' do
      if logged_in? #only logged_in users can be logged out
        session.clear
        redirect '/login'
      else
        redirect '/'
      end
    end

end
