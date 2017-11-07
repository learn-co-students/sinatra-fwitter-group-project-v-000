class UserController < ApplicationController

    get '/login' do
      if logged_in?
        redirect to '/tweets'
      else
        erb :'users/login'
      end
    end

    get '/signup' do
       if logged_in?
         redirect to '/tweets'
       else
          erb :'users/signup'
       end
    end

    post '/signup' do
      if params.values.any? {|params| params == ""}
        redirect to '/signup'
      else
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect  '/tweets'
      end
    end


    post '/login' do

      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect to '/login'
      else
        redirect to '/'
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end

end
