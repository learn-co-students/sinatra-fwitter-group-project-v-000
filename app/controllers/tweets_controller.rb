class TweetsController < ApplicationController


    get '/tweets/new' do
      if logged_in?
        erb :'/tweets/create_tweet'
      else
        redirect to "/login"
      end
    end

    get '/tweets' do
      if !logged_in?
        redirect to "/login"
      else
        @user = current_user
        @tweets = Tweet.all
        erb :'/tweets/tweets'
      end
    end

    post '/tweets' do
      if logged_in? && !params[:content].empty?
        @tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/new"
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @user = current_user
        @tweet = Tweet.find_by(user_id: @user.id)
        erb :'/tweets/show_tweet'
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @user = current_user
        @tweet = Tweet.find_by(user_id: @user.id)
        erb :'/tweets/edit_tweet'
      else
        redirect to "/login"
      end
    end

    patch '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by(user_id: current_user.id)
        @tweet.content = params[:content] if !params[:content].empty?
        @tweet.save
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        redirect to "/login"
      end
    end

    delete '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id == current_user.id
          @tweet.delete
        end
      else
        redirect to "/login"
      end
    end



end
