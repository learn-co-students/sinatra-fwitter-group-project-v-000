
class UsersController < ApplicationController

    get '/signup' do
        # binding.pry
        if logged_in?
            redirect "/tweets"
        else
            erb :'users/create_user'
        end
    end

    post '/signup' do
        # binding.pry
        if params[:username].empty? || params[:password].empty? || params[:email].empty?
            redirect '/signup'
        else
            @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end


    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/user/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

end
