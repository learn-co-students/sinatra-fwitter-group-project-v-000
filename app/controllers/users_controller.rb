class UsersController < ApplicationController

	get('/users/:slug'){

		@user = User.find_by(:username => params[:slug])

		erb :'users/show'
	}

	get('/signup'){
		if !logged_in?
			erb :'/users/create_user', locals: {message: "Please sign up before you sign in"}
		else
			redirect to '/tweets'
		end
	}

	post('/signup'){
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else	
       @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
       @user.save
       session[:user_id] = @user.id
       redirect to '/tweets'
   	end		
	}

  get('/login'){
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  }

	post('/login'){

		user = User.find_by(:username => params[:username])

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to '/tweets'
		else
			redirect to '/signup'
		end
	}

	get('/logout'){
		if logged_in?
			session.destroy
			redirect to '/'
		else
			redirect to '/'
		end
	}
end
