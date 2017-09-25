class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  #displays the user signup
  #only shows the sign-up page if user is not logged in if they are logged in, redirects them to their tweets
    get "/signup" do
        if !logged_in?
  		erb :"users/signup"
    else
      redirect to '/tweets'
  	end
  end

  #Users submission form is loaded via the POST request to /signup
    post "/signup" do
  		user = User.new(email: params[:email], username: params[:username], password: params[:password])
  		user.save
      #sets the session to the new users ID and directs them to their tweets
      session[:user_id] = @user.id
      redirect to '/tweets'
  	end

  #renders the login page for a user
    get "/login" do
      erb :"users/login"
    end

  #login form is loaded via post /login request
    post "/login" do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
      else
          redirect "/signup"
      end
    end

    get "/logout" do
  		session.clear
  		redirect "/"
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
