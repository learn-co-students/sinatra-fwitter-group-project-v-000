class TweetsController < ApplicationController

    get '/tweets' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
          redirect '/login'
        end
    end

    get '/tweets/new' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            erb :'/tweets/new'
        else
          redirect '/login'
        end
    end
    
    post '/tweets' do
        if params[:content] != ""
            @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            # binding.pry
            redirect "/tweets/#{@tweet.id}"
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else
          redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @user = User.find_by(id: session[:user_id])
        if !@user.nil?
            # binding.pry
            if !params[:content] != ""
                @tweet = Tweet.find(params[:id])
                @tweet.update(content: params[:content])
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

end