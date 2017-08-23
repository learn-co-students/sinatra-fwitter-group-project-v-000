class UserController < ApplicationController
	get "/signup" do
	  	if !!session[:id]
	  		redirect "/tweets"
	  	else
	  		erb :"users/create_user"
	  	end
  	end

  	post "/signup" do
	  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
	  		redirect "/signup"
	  	else
	  		user = User.create(params)
	  		session[:id] = user.id
	  	end
	  	redirect "/tweets"
 	 end

 	get "/login" do 
	  	if !!session[:id]
	  		redirect "/tweets"
	  	else
	  		erb :"users/login"
	  	end
  	end

	post "/login" do
	  	user = User.find_by(params)
	  	session[:id] = user.id
	  	redirect "/tweets"
	end

	get "/logout" do 
	  	session.clear
	  	redirect "/login"
 	end

 	get "/users/:slug" do
	  	@user = User.find_by_slug(params[:slug])
	  	erb :"users/show"
  	end

end