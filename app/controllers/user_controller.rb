class UserController < ApplicationController
	#==================== SIGNUP ============================
  get '/signup' do
		if logged_in?
      redirect to "/tweets"
		else
      erb :'/users/create_user'
    end
  end
	
	post '/signup' do
		if valid_signup?
			@user = User.create(params)
			session[:user_id] = @user.id
			redirect to "/tweets"
		else
			redirect to "/signup"
		end
	end
	#--------------------------------------------------------


	#==================== LOGIN =============================
	get '/login' do
		if logged_in?
			redirect to "/tweets"
		else
			erb :'/users/login'
		end
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect to "/tweets"
		else
			redirect to "/signup"
		end
	end

	get '/tweets' do
		@user = User.find_by(params[:userid])
		if !logged_in?
			redirect to "/login"
		else
			erb :'/tweets/tweets'
		end
	end

	get '/:userid/tweets' do
		@user = User.find_by(params[:userid])
		erb :'/tweets/tweets'
	end
	#--------------------------------------------------------


	#==================== USER SHOW PAGE ====================
		get '/users/:userslug' do
			@user = User.find_by(params[:userid])
			@user.save
			erb :'/tweets/tweets'
		end
	#--------------------------------------------------------


	#==================== LOGOUT ============================
	get '/logout' do
		if logged_in?
			# binding.pry
			session.clear
			redirect to "/login"
		else
			redirect to "/"
		end
	end
	#--------------------------------------------------------

end