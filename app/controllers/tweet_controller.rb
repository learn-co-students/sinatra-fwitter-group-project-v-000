class TweetController < ApplicationController


    get '/tweets/new' do
      if !logged_in?
        redirect '/login'
      end
      erb :'/tweets/create_tweet'
    end

    get '/tweets' do
      if !logged_in?
        redirect '/login'
      else
        @user = current_user
        erb :'/tweets/tweets'
      end
    end

    post '/tweets' do
      if !params[:tweet][:content].empty?
        @tweet = Tweet.create(params[:tweet])
        @tweet.user_id = current_user.id
        @tweet.save
        erb :'/tweets/show_tweet'
      else
        redirect '/tweets/new'
      end
    end

    get '/tweets/:id' do
      if !logged_in?
        redirect '/login'
      end
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
      if !logged_in?
        redirect '/login'
      end
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if params[:tweet][:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(params[:tweet])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      end
    end

    delete '/tweets/:id/delete' do
      @tweet = Tweet.find(params[:id])
      if @tweet.id == current_user.id
        @tweet.delete
      end
    end
end
