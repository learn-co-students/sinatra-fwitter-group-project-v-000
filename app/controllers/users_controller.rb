
class UsersController < ApplicationController

  get '/signup' do
    # puts "Get Sign Up Route"
    if logged_in?
      # puts "User Already Logged In"
      redirect to "/tweets"
    else
      # puts "Allow Sign Up"
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    # puts "Sign Up Params = #{params}"
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
		if user.save
      # puts "saved user -> load tweets page"
      session[:user_id] = user.id
      redirect to "/tweets"
		else
      # puts "FAILURE TO SAVE USER"
			redirect to "/signup"
		end
  end


  get '/login' do
    # puts "Get Login Route"
    if logged_in?
      # puts "User Already Logged In"
      redirect to "/tweets"
    else
      # puts "Allow Log In"
      erb :'/users/login'
    end
  end

  post '/login' do
    # puts "Post Login Route"
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      # puts "User Successfully logged in"
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      # puts "FAILURE TO FIND USER"
      redirect to "/login"
    end
  end

  get '/logout' do
    # puts "Log Out Route"
    if logged_in?
      # puts "Allow Log Out"
      session.clear
    # else
    #   puts "User Not Logged In"
    end
    redirect to "/login"
  end

  get '/users/:slug' do
    puts "User Show Route"
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
    # if logged_in?
    #   puts "User = #{session[:user_id]}"
    #   @user = User.find(session[:user_id])
    #   erb :'/users/show'
    # else
    #   puts "User Not Logged In"
    #   redirect to "/login"
    # end
  end

end

# rspec spec/controllers/application_controller_spec.rb
# rspec spec/models/user_spec.rb

# learn --f-f << -- only reports the first spec failure
