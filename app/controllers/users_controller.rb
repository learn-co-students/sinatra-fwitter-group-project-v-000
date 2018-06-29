class UsersController < ApplicationController


    get '/signup' do
      erb :'/users/create_user'
    end

    get '/login' do
      erb :'/users/login'
    end

    post '/signup' do
      #raise params.inspect
      username = params[:username]
      email = params[:email]
      password = params[:password]

      if username != "" && email != "" && password != ""
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        redirect to '/tweets'
      else
        redirect to '/signup'
      end

    end

    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/tweets"
      else
        if logged_in?
          redirect to "/tweets"
        else
          redirect to '/login'
        end
      end
    end

    get "/logout" do
      if logged_in?
        session.clear
        redirect "/"
      else
          redirect "/login"
      end

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
