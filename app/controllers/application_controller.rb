require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
	end

	get '/' do 
		erb :index
	end

	get '/tweets' do 
		if logged_in?
			erb :'tweets/tweets'
		else
			redirect '/login'
		end
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

	get '/users/:slug' do 
		@user = User.find_by_slug(params[:slug])
		@user_tweets = @user.tweets
		erb :'users/user_tweets'
	end


	post '/signup' do 
		@user = User.new(params)
		if @user.save
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/signup'
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:id] = @user.id
			redirect '/tweets'
		else
			redirect '/'
		end
	end

	get '/tweets/new' do
		if logged_in?
			erb :'tweets/create_tweet'
		else
			redirect '/login'
		end
	end

	post '/tweets' do 
			@tweet = Tweet.new 
			@tweet.content = params[:content]
			@tweet.user = current_user
		if	@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect '/tweets/new'
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
		redirect '/login' if !logged_in?
		@tweet = Tweet.find(params[:id])
		redirect '/tweets' if @tweet.nil? || @tweet.user.nil? || @tweet.user != current_user
		erb :'tweets/edit_tweet'
	end

	delete '/tweets/:id/delete' do 
		@tweet = Tweet.find(params[:id])
		@tweet.delete if @tweet.user == current_user
		redirect '/tweets'
	end

	patch '/tweets' do 
			@tweet = Tweet.find(params[:id]) 
			@tweet.content = params[:content]
		if	@tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect "/tweets/#{params[:id]}/edit"
		end
	end

	helpers do
		def logged_in?
		  !!session[:id]
		end

		def current_user
		  @current_user ||= User.find(session[:id])
		end
	end

end