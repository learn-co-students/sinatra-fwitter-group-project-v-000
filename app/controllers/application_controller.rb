require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
        enable :sessions
        set :session_secret, "142"
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/' do
        erb :index
    end

    get '/signup' do
        erb :signup
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != ""
            user = User.new(name: params[:username], email: params[:email], password: params[:password])

            if user.save
                redirect "/login"
            else
                redirect "/fail"
            end
        else
            redirect "/fail"
        end
    end

    get '/login' do
        erb :login
    end

    post '/login' do
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/fail'
        end
    end

    get '/logout' do
        session[:user_id] = nil
        redirect '/'
    end

    get '/tweets' do
        unless Util.signed_in? session
            redirect '/'
        end

        @user = User.find_by(id: session[:user_id])

        erb :tweets
    end

    get '/tweets/new' do
        unless Util.signed_in? session
            redirect '/'
        end

        erb :'tweets/new'
    end

    get '/tweets/:id/edit' do
        unless Util.signed_in? session
            redirect '/'
        end

        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.find_by(id: params[:id])

        unless @user.id == @tweet.user_id
            redirect '/tweets/' + @tweet.id
        end

        erb :'tweets/edit'
    end

    get '/tweets/:id' do
        unless Util.signed_in? session
            redirect '/'
        end

        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.find_by(id: params[:id])

        erb :'tweets/show'
    end

    patch '/tweets/:id' do
        unless Util.signed_in? session
            redirect '/'
        end

        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.find_by(id: params[:id])

        unless @user.id == @tweet.user_id
            redirect '/tweets/' + @tweet.id.to_s
        end

        @tweet.update(content: params[:content])

        redirect '/tweets/' + @tweet.id.to_s
    end

    delete '/tweets/:id' do
        unless Util.signed_in? session
            redirect '/'
        end

        @user = User.find_by(id: session[:user_id])
        @tweet = Tweet.find_by(id: params[:id])

        unless @user.id == @tweet.user_id
            redirect '/tweets/' + @tweet.id.to_s
        end

        @tweet.delete

        redirect '/tweets'
    end

    post '/tweets' do
        unless Util.signed_in? session
            redirect '/'
        end

        unless params[:content] != ""
            redirect '/tweets/new'
        end

        user = User.find_by(id: session[:user_id])
        user.tweets << Tweet.create(content: params[:content])
        redirect '/tweets'
    end

end