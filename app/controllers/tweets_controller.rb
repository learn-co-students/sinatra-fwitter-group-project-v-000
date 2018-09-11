class TweetsController < ApplicationController

    get '/tweets' do
      if logged_in?
        @user = current_user
        @tweets = Tweet.all
        erb :'/tweets/tweets'
      else
        redirect to '/login'
      end
    end

    get '/tweets/new' do
      if !logged_in?
        redirect to "/login"
      else
        erb :"tweets/create_tweet"
      end
    end

    post '/tweets' do
      if logged_in?
        if params[:content].empty?
            redirect to "/tweets/new"
        else
            @tweet = current_user.tweets.create(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
        end
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by(params[:id])
        erb :"tweets/show_tweet"
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id/edit' do
      if !logged_in?
        redirect to "/login"
      else
        @tweet = Tweet.find_by(params[:id])
      
        if @tweet && @tweet.user == current_user
          erb :"tweets/edit_tweet"
        else
          redirect to "/tweets"
        end
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if params[:content] != ""
        @tweet.update(:content => params[:content])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end


    delete '/tweets/:id/delete' do
        @current_user = User.find_by_id(session[:user_id])
        @tweet = Tweet.find_by_id(params[:id])
      if @current_user.tweets.find_by_id(@tweet.id)
            @tweet.delete
      end
      
        redirect to '/tweets'
    end
end
