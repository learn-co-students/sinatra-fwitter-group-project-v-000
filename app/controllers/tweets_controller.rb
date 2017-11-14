class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :"tweets/index"
        else
            redirect "/login"
        end
    end 

    get '/tweets/new' do
        if logged_in?
            @user = current_user
            erb :"tweets/new"
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if logged_in? && !params[:content].empty?
            @user = current_user
            @user.tweets.create(content:params[:content])
            redirect "/users/#{@user.slug}"
        elsif logged_in? && params[:content].empty?
            redirect "/tweets/new"
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        if logged_in? && Tweet.find(params[:id]).user == current_user && !params[:content].empty?
            Tweet.find(params[:id]).update(content:params[:content])
            redirect "/users/#{current_user.slug}"
        elsif logged_in?
            redirect "/tweets/#{params[:id]}/edit"
        else
            redirect "/login"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :"tweets/show"
        else
            redirect "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? && Tweet.find(params[:id]).user == current_user
            @tweet = Tweet.find(params[:id])
            erb :"tweets/edit"
        elsif logged_in? && Tweet.find(params[:id]).user != current_user
            redirect "/tweets"
        else
            redirect "/login"
        end
    end
    
    delete '/tweets/:id/delete' do
        if logged_in? && Tweet.find(params[:id]).user == current_user
            Tweet.find(params[:id]).delete
            redirect "/tweets"
        elsif logged_in?
            redirect "/tweets/#{params[:id]}"
        else
            redirect "/login"
        end

    end

end