class UsersController < ApplicationController

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end

    get '/signup' do
        if logged_in?
          redirect to "/tweets"
  else
        erb :'/users/create_user' , locals: {message: "Please sign up to sign in"}
    end
  end


  post '/signup' do #this now passes all Signup tests
        if logged_in?
          redirect '/tweets'
        elsif params[:username] == "" || params[:email] == "" || params[:password] == ""
      		redirect to "/signup"
        else
        		@user = User.create(params)
            @user.save
        		session[:user_id] = @user.id
            redirect '/tweets'
      	end
    	end

get '/login' do
if logged_in?
  redirect to "/tweets"
else
  erb :'/users/login'
end
end

   post '/login' do
        user = User.find_by(username: params[:username])
     if user && user.authenticate(params[:password])
        session[:user_id] = user.id
       redirect to '/tweets'
     else
       redirect to '/login'
     end
   end

   get '/logout' do
     if logged_in?
       session.destroy
       redirect to '/login'
     else
       redirect to '/'
       end
   end


end
