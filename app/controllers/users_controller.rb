class UsersController < ApplicationController
    
    get '/login' do

        if !logged_in?
          erb :"users/login" 
        else
          erb "/tweets"
        end   

    end    

    post '/login' do
        user = User.find_by(username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"    
        end    
    end

 
end
