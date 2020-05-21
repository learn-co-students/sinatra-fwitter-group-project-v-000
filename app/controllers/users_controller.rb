class UsersController < ApplicationController

    get '/signup' do
        if is_logged_in?
        # binding.pry
        redirect '/tweets'
        else
        erb :'/users/signup'
        end
    end

    post '/signup' do
        user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
        session[:user_id] = user.id
        if user.username != " " && user.email != " "
            redirect '/signup'
        else
            redirect '/tweets'
        end
    end    
end
    # user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
    # session[:user_id] = user.id

    # redirect to '/tweets'

    #     user = User.new(:username=>params[:username], :email=>params[:email], :password=>params[:password])
    #     if user.save && user.username != " " && user.email != " "
    #         session[:user_id] = user_id 
    #     else
    #        redirect to '/signup'
    #     end
    #   redirect to '/index'  
    # end 

        # params.each do |input|
        #     if input.empty?
        #     redirect to '/signup'
        #     else

