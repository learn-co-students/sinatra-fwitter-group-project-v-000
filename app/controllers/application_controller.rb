require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
  	# binding.pry
  	if logged_in?
  		redirect '/tweets'
  	else
    	erb :'registrations/signup'
    end
# binding.pry
  end

  post '/signup' do 
  	user = User.new(username: params[:username], email: params[:email], password: params[:password])
# binding.pry
  	if user.save

  		session[:user_id] = user.id
  		# binding.pry
  		redirect '/tweets'
  	else
  		@error = user.errors.messages
  		redirect '/signup'
  	end
  end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
    	erb :'sessions/login'
    end
  end

  post '/login' do 

  	user = User.find_by(username: params[:username])

  	if user.authenticate(params[:password])
  		session[:user_id] = user.id
  		#binding.pry
  		redirect '/tweets'
  	else
  		# binding.pry
  		redirect '/login'
  	end
  end

  get '/logout' do
  	session.clear
  	redirect '/login'
  end

  get '/users/:id' do
  	
  		@user = User.find_by(username: params[:id])
	if @user
		@tweets = @user.tweets
		# binding.pry
		erb :'users/show'
  	end
  end

  get '/tweets' do 
	# binding.pry
  	if logged_in?
  		# binding.pry
  		@user =  User.find(session[:user_id])
  		@tweets = Tweet.all
  		erb :'tweets/index'
  	else
  		redirect '/login'
  	end

  	
  end

  get '/tweets/new' do 

  	if logged_in?
  		@user =  current_user
 	 	erb :'tweets/new'
  	else
  		redirect '/login'
  	end
 
  end

  post '/tweets' do
  	new_tweet = current_user.tweets.build(content: params[:content])
# binding.pry
  	if new_tweet.save
  		redirect '/tweets'
  	else
  		redirect 'tweets/new'
  	end
  end

  get '/tweets/:id' do
  	if logged_in?
  		
  		@user = User.find(session[:user_id])
  		
  		@tweet = Tweet.find(params[:id])
  		# binding.pry
  		erb :'tweets/show'
  		
  	else
  		redirect '/login'
  	end
  
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@user = current_user
  		
  		@tweet = @user.tweets.find { |tweet| tweet.id == params[:id].to_i}
  		# binding.pry
  		erb :'tweets/edit'
  		
  	else
  		redirect '/login'
  	end
  	
  end

  patch '/tweets/:id' do
  	# binding.pry
  	edit_tweet = current_user.tweets.find { |tweet| tweet.id == params[:id].to_i }

  	edit_tweet.content = params[:content]

  	if edit_tweet.save
	  redirect "/tweets/#{params[:id]}"
	else
	  redirect "/tweets/#{params[:id]}/edit"
	end
  end


  delete '/tweets/:id/delete' do


  	if logged_in?
  		tweet = Tweet.find(params[:id])
  		
  		tweet.delete if current_user.tweets.include?(tweet)
 
  		redirect '/tweets'
  	else
  	  redirect '/login'
  	end
    
  end

  helpers do
  	def logged_in?
  		!!session[:user_id]
  	end

  	def text_field(owner, type)
  		"<input type=\"#{type}\" id=\"#{type}\" name=\"#{type}\">"
  	end

  	def current_user
  		User.find(session[:user_id])
  	end
  end

end