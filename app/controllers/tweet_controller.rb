class TweetController < ApplicationController

  # tweets
    get '/tweets' do
      if logged_in?
        erb :'tweets/tweets'
      else
        redirect '/login'
      end
    end

    post '/tweets' do
      if logged_in?
        @tweet = Tweet.create(user: current_user, content: params[:content])
        erb :'tweets/tweets'
      else
        redirect '/login'
      end
    end

    get '/tweets/new' do
      if logged_in?
        erb :'tweets/create_tweet'
      else
        erb :'users/login'
      end
    end

    get '/tweets/:id/edit' do
      @tweet = Tweet.find_by(id: params[:id])
      if logged_in? && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        erb :'users/login'
      end
    end

    post '/tweets/:id/edit' do
      @tweet = Tweet.find_by(id: params[:id])
      if params[:content] == ""
        erb :'tweets/#{params[:id]}/edit'
        #send a message that tweets can't be blank
      else
        @tweet.update(content: params[:content])
        redirect '/tweets'
      end
    end

    get '/tweets/:id/delete' do
      @tweet = Tweet.find_by(id: params[:id])
      @tweet.delete
      redirect '/tweets'
    end

end
