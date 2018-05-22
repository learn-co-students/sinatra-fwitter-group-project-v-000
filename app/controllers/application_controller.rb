require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  ## Main Views ##

  get '/' do
    puts "Main Index Page"
    erb :index
  end


  ## User Views ##

  get '/signup' do
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
    if logged_in?
      # puts "User Already Logged In"
      redirect to "/tweets"
    else
      # puts "Allow Log In"
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      puts "User Successfully logged in"
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      puts "FAILURE TO FIND USER"
      redirect to "/login"
    end
  end

  get '/logout' do
    if logged_in?
      puts "Allow Log Out"
      session.clear
      redirect to "/"
    else
      puts "User Not Logged In"
      redirect to "/login"
    end
  end


  ## Tweet Views ##

  get '/tweets' do
    puts "Session user = #{session[:user_id]}"
    @user = User.find(session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    puts "Params = #{params}"
    tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
    redirect to "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = tweet.find(params[:id])
    tweet.delete
    redirect to '/tweets'
  end


  ## Helpers ##

  helpers do
    def logged_in?
      puts "Check if Logged in"
      !!session[:user_id]
    end

    def current_user
      puts "Find Current User"
      User.find(session[:user_id])
    end
  end

end

# Referenced Labs
# nyc-sinatra-v-000 || playlister-sinatra-v-000 || sinatra-complex-forms-associations-v-000
# sinatra-secure-password-lab-v-000 || sinatra-user-auth-v-000

# rspec spec/controllers/application_controller_spec.rb
# rspec spec/models/user_spec.rb

# learn --f-f << -- only reports the first spec failure
