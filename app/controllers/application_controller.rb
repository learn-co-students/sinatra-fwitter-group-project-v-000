require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'longmire'
  end

  helpers Helpers

  get '/' do
  	erb :index
  end

  get '/signup' do
  	if logged_in?
  		redirect '/tweets'
  	else
	  	erb :'users/create_user'
	  end
  end

  get '/login' do
  	if logged_in?
  		redirect '/tweets'
  	else
  	  erb :'users/login'
  	end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  		redirect '/login'
  	else
	  	redirect '/'
	  end
  end

  post '/signup' do
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
  		redirect '/signup'
  	else
	  	@user = User.create(params)
	  	session[:user_id] = @user.id
	  	redirect '/tweets'
	  end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect '/tweets'
  	else
  		redirect '/login'
  	end
  end

  get '/tweets' do
  	if logged_in?
  	  erb :'tweets/tweets'
  	else 
  		redirect '/login'
  	end
  end

  get '/users/:slug' do
  	@tweets = Tweet.where({ user_id: User.find_by_slug(params[:slug]).username })
  	erb :'users/show'
  end

  get '/tweets/new' do
  	if logged_in?
  		erb :'tweets/create_tweet'
  	else
  		redirect '/login'
  	end
  end

  post '/tweets' do
  	if logged_in?
  		if params[:content] == ""
  			redirect '/tweets/new'
  		else
	  		tweet = Tweet.create(content: params[:content], user_id: current_user.id)
	  		redirect '/tweets'
	  	end
  	else
  		redirect '/login'
  	end
  end

  get '/tweets/:id' do
    if logged_in?
	    @tweet = Tweet.find(params[:id])
	    erb :'tweets/show_tweet'
	  else
	  	redirect '/login'
	  end
  end

  get '/tweets/:id/edit' do
  	if logged_in?
  		@tweet = Tweet.find(params[:id])
  		if @tweet.user_id == current_user.id
  			erb :'tweets/edit_tweet'
  		else
  			redirect '/tweets'
  		end
  	else
  		redirect '/login'
  	end
  end

  patch '/tweets/:id' do
  	if logged_in?
  		@tweet = Tweet.find(params[:id])
  		if @tweet.user_id == current_user.id
  			if params[:content] != ""
  				@tweet.update(content: params[:content])
  				erb :'tweets/show_tweet'
  			else
  				redirect "/tweets/#{@tweet.id}/edit"
  			end
  		else
  			redirect '/tweets'
  		end
  	else
  		redirect '/login'
  	end
  end

  delete '/tweets/:id' do
  	if logged_in?
  		tweet = Tweet.find(params[:id])
  		if tweet.user_id == current_user.id
				tweet.destroy
			end
			redirect '/tweets'
  	else
  		redirect '/login'
  	end  		
  end

end