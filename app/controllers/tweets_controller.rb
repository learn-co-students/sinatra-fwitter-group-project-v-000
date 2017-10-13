class TweetsController < ApplicationController

    get '/tweets' do
      if Helpers.is_logged_in?(session)
        @tweets = Tweet.all
        @user = User.find(session[:user_id])
        erb :'tweets/index'
      else
        redirect to '/login'
      end
    end

    get '/tweets/new' do
      if Helpers.is_logged_in?(session)
        @user = User.find(session[:user_id])
        erb :'tweets/new'
      else
        redirect to '/login'
      end
    end

    post '/tweets' do
      if !!params[:tweet][:content] && !params[:tweet][:content].empty?
        @tweet = Tweet.new(:content => params[:tweet][:content], :user_id => session[:user_id])
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to 'tweets/new'
      end
    end

    get '/tweets/:id' do
      if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        erb :'tweets/show'
      else
        redirect to "/login"
      end
    end

    get '/tweets/:id/edit' do
      if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit'
      else
        redirect to "/login"
      end
    end

    patch '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if !!params[:content] && !params[:content].empty?
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end

    delete '/tweets/:id/delete' do
      @tweet = Tweet.find(params[:id])

      if Helpers.current_user(session).id == @tweet.user_id
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to "/tweets/#{@tweet.id}/edit"
      end
    end

end
