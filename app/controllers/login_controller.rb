class LoginController < ApplicationController

    get '/signup' do
        logged_in? ? redirect('/tweets') : erb(:"login/signup")
    end

    post '/signup' do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
        session[:id] = @user.id
        redirect('/tweets')
        else
        puts @user.errors # log the errors to the command line
        redirect('/signup')
        end
    end

    get '/logout' do
        session.clear
        redirect('/login')
    end

    get '/login' do
        logged_in? ? redirect('/tweets') : erb(:"login/login")
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user.authenticate(params[:password])
        session[:id] = user.id
        redirect '/tweets'
        else
        redirect '/login'
        end
    end
end
