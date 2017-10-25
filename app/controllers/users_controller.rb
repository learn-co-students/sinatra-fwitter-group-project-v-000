class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
		  redirect '/tweets' 
        else
 	      erb :'/users/create_user'
        end   
 	end

 	post '/signup' do
        @user = User.new
        @user.email = params[:email]
        @user.username = params[:username]
        @user.password = params[:password]
        if @user.save
         session[:user_id] = @user.id
    	   redirect '/tweets'
        else 
            redirect '/signup'
        end
 	end

    get '/users/:slug' do
        @user=User.find_by_slug(params[:slug])
        erb :'/users/show'
    end
end