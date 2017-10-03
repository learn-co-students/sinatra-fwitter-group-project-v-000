class TweetsController < ApplicationController

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to "/login"
        end
    end

    get '/tweets' do
        if logged_in?
            @user = User.find(session[:user_id])
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect to "/login"
        end
    end

    post '/tweets' do
        if logged_in?
            if params["content"] != ""
                @user = current_user
                @tweet = Tweet.new(content: params["content"])
                @tweet.user = @user
                @tweet.save

                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/new"
            end
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        else
            redirect to "/login"
        end
    end

    patch '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == current_user.id
                if params["content"] != ""
                    @tweet.update(content: params["content"])
                    redirect to "/tweets/#{@tweet.id}"
                else
                    redirect to "/tweets/#{@tweet.id}/edit"
                end
            else 
                redirect to "/tweets"
            end
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
                if @tweet.user_id == current_user.id
                    @tweet.delete
                    redirect to "/tweets"
                else
                    redirect to"/tweets"
                end
        else
            redirect to "/login"
        end
    end

end