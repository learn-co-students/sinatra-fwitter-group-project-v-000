require './config/environment'

class ApplicationController < Sinatra::Base

 	configure do
	    set :public_folder, 'public'
	    set :views, 'app/views'
	    enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
	    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
	    	user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
	    	session[:user_id] = user.id
	    	redirect "/tweets"
		else
	    	redirect "/signup"
		end
	end


	get "/login" do
		erb :'users/login'
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
	    if user && user.authenticate(params[:password])
	        session[:user_id] = user.id
	        redirect "/tweets"
	    else
	        redirect "/users/login"
	    end
	end

	get "/logout" do
		session.clear
		redirect "/login"
	end

	get "/tweets" do
		@tweets = Tweet.all
		erb :'tweets/tweets'
	end

	get "/tweets/new" do
		erb :'tweets/create_tweet'
	end

	post "/tweets/new" do
		if !params[:content].empty?
			tweet = Tweet.create(:user_id => current_user.id, :content => params[:content])
			redirect "tweets/#{tweet.id}"
		else
			redirect 'tweets/new'
		end
	end

	get "/tweets/:id" do
		@tweet = Tweet.find_by_id(params[:id])
		erb :'tweets/show_tweet'
	end

	get "/tweets/:id/edit" do
		@tweet = Tweet.find_by_id(params[:id])
		erb :'tweets/edit_tweet'
	end

	post "/tweets/:id" do
		@tweet = Tweet.find_by_id(params[:id])
		if !params[:content].empty?
			@tweet.update(:content => params[:content])
			erb :'tweets/show_tweet'
		else
			redirect "/tweets/#{@tweet.id}/edit"
		end
	end

	post "/tweets/:id/delete" do
		@tweet = Tweet.find_by_id(params[:id])
		if @tweet.user == current_user
			@tweet.delete
			redirect 'tweets/new'
		else 
			redirect "/tweets/#{@tweet.id}"
		end
	end

    get "/users/:slug" do 
    	erb :'/users/show'
    end

    get "/delete" do

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