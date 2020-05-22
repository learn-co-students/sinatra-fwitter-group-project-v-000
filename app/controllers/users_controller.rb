class UsersController < ApplicationController

    get '/signup' do
        if is_logged_in?
        redirect '/tweets'
        else
        erb :'/users/signup'
        end
    end

    post '/signup' do
        # binding.pry
        # user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
        # session[:user_id] = user.id
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else
            user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
            session[:user_id] = user.id
            redirect '/tweets'
        end
    end    

    get '/login' do
        if is_logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    # post '/login' do
    #     binding.pry
    #     user = User.find_by(:username=>params[:username])
    #     session[:user_id] = user.id
    #     if user && user.authenticate(params[:password])
            
    #         redirect to '/tweets'
    #     else
    #         redirect to '/login' 
    #     end   
    # end

    post '/login' do
        # binding.pry
        user = User.find_by(:username => params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            # binding.pry
            redirect to '/tweets'

        else
            erb :'/users/login'
        end
    end
        
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/login'
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

