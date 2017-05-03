class TweetsController < ApplicationController
    use Rack::Flash
    get '/tweets' do
        if logged_in?
            @user = User.find_by_id(session[:user_id])
            erb :'/tweets/tweets'
        else
            redirect to "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/create_tweet'
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            @tweet = Tweet.create(:content => params[:content])
            @tweet.user = current_user
            @tweet.save
            @user = @tweet.user
            erb :"/tweets/tweets"
        else
            redirect "/tweets/new"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect "/login"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user.username == current_user.username
                erb :'/tweets/edit_tweet'
            else
                flash[:message] = "You are not #{@tweet.user.username}!"
                erb :'/tweets/tweets'
            end
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if !params[:content].empty?
            @tweet.update(:content => params[:content])
            @user = current_user
            erb :"/tweets/tweets"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    get '/tweets/:id/delete' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
            if current_user == @tweet.user
                @tweet.delete
                redirect '/tweets'
            end
        else
            redirect "/login"
        end
    end
end