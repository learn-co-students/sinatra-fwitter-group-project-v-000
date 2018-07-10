require "./app/models/user"
class UsersController < ApplicationController


  get "/signup" do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end


  post "/signup" do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup'
    end

    user = User.create(:username => params[:username], :password_digest => params[:password], :email => params[:email])
    session[:user_id] = user.id
    if logged_in?
      
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end



  get "/login" do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end


  post "/login" do
    user = User.find_by(username: params[:username], email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup' 
    end
  end




  get "/logout" do
    session.clear
    redirect "/"
  end





  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end
  
    
    def slug
      self.name.gsub(" ", "-").gsub(/[^\w-]/, '').downcase
    end


    def find_by_slug(value)
      self.all.detect{ |a| a.slug == value}
    end

end

