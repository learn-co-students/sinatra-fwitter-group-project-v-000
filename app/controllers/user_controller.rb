class UserController < ApplicationController

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/account'
    end

    get '/signup' do 
        !logged_in? ? (erb :'/users/signup') : (redirect "/tweets")
    end 

    post '/signup' do 
        user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        !!user.save ? (session[:user_id] = user.id) && (redirect "/tweets") : (redirect "/signup")
    end

    get '/login' do
        !logged_in? ? (erb :'/users/login') : (redirect '/tweets')
    end

    post "/login" do
        user = User.find_by(:username => params[:username])
        !!user && user.authenticate(params[:password]) ? (session[:user_id] = user.id) && (redirect "/tweets") : (redirect "/signup")
    end

    get "/logout" do
        !!logged_in? ? (session.destroy) && (redirect '/login') : (redirect "/")
    end

end