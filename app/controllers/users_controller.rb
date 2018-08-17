class UsersController < ApplicationController

  get "/signup" do
    if   !!session[:user_id]
      redirect '/tweets'
    end
      erb :'users/create_user'
    end

    post "/signup" do
    #binding.pry
      if !!session[:user_id]
        redirect '/tweets'
      end
      if params[:username] == ""
        redirect "/signup"
      end
      if params[:email] == ""
        redirect "/signup"
      end
      if params[:password] == ""
        redirect "/signup"
      end
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      if @user
        session[:user_id] = @user.id
  	     redirect "/tweets"
      else
        redirect "/login"
  	  end
    end

    get '/account' do
      #binding.pry
      @user = User.find(session[:user_id])

      erb :'users/show'
    end


    get "/login" do
      if !!session[:user_id]
        redirect "/tweets"
      end
      erb :'users/login'
    end

    post "/login" do
      if !!session[:user_id]
        redirect "/tweets"
      end
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
      else
        redirect "/login"
      end
    end

    get '/users/:slug' do
        @user = find_by_slug(params[:slug])
      if !!session[:user_id]
          redirect to "/users/#{user.slug}"
      else
        redirect to '/login'
      end
  end

    get "/logout" do
      session.clear
      redirect "/login"
    end

    post "/logout" do
      session.clear
      redirect "/login"
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
