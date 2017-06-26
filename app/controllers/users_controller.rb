require "./config/environment"

class UsersController < ApplicationController

get "/" do
	erb :'users/index'
end



get "/signup" do
	if Helpers.logged_in?(session) 
	redirect '/tweets'
	else
	erb :'users/signup'
	end
end


post "/signup" do
	# if Helpers.logged_in?(session) 
	# redirect '/tweets'
	# else

			if params[:username] != "" && params[:password] != "" && params[:email] != ""
			user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    						if user.save
    					    session[:user_id] = user.id
							redirect "/tweets"
							end
    		else
    		    redirect "/signup"
    		end

	# end
end


get "/login" do
	if Helpers.logged_in?(session) 
	redirect '/tweets'
	else
	erb :'users/login'
	end
end

post "/login" do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          			redirect "/tweets"
      else
          redirect "/signup"
      end
end

get '/users/:username/home' do
	if Helpers.logged_in?(session)
    @user = Helpers.current_user(session)
    erb :'/users/home'

    else
     redirect '/login'
    end

end


get '/users/:slug' do
	if Helpers.logged_in?(session)
    @user = User.find_by_slug(params[:slug])
    erb :'/users/home'
    else
     redirect '/login'
    end
end





get "/success" do
	@user = Helpers.current_user(session)
	if Helpers.logged_in?(session)
		
		erb :'users/home'
	else
		redirect "/login"
	end
end


get "/failure" do
	erb :'users/failure'
end



get "/logout" do
	session.clear
	redirect "/login"
end



end