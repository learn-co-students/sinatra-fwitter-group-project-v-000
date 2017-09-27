class UsersController < ApplicationController

  get '/' do
      erb :'index'
  end


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end



  #displays the user signup
  #only shows the sign-up page if user is not logged in if they are logged in, redirects them to their tweets
    get "/signup" do
    if logged_in?
      redirect '/tweets'
    else
      !logged_in?
  		erb :"users/signup"
  	end
  end

  #Users submission form is loaded via the POST request to /signup
    post "/signup" do
      if params[:username].empty? || params[:email].empty? || params[:password].empty?
       redirect '/signup'
     else
  		@user = User.new(username: params[:username], email: params[:email], password: params[:password])
  		@user.save
      session[:user_id] = @user.id
      redirect "/tweets"
  	end
  end

  #renders the login page for a user
  #doesn't let user view the login page if already logged in"
    get "/login" do
      if logged_in?
      redirect "/tweets"
    end
      erb :'/users/login'
  end

  #login form is loaded via post /login request
    post "/login" do
      user = User.find_by(:username => params[:username])
      if user && @user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
      else
          redirect "/signup"
      end
    end

    get '/logout' do
       if logged_in?
         session.destroy
         redirect '/login'
       else
         redirect '/'
       end
     end

end
