class TweetsController < ApplicationController

  # get '/tweets' do
  #   # raise session[:user_id].inspect
  #   # if logged_in
  #     erb :'tweets/tweets'
  #   # end
  # end

    get '/tweets' do
      if !logged_in?
        redirect '/login'
      else
        @tweets = Tweet.all
        erb :'tweets/tweets'
      end
    end

    get '/tweets/new' do
      if logged_in?
        erb :'tweets/create_tweet'
      else
        redirect to '/login'
      end
    end

    post '/tweets' do
      redirect '/login' unless logged_in?
      if !params[:content].empty?
        @tweet = current_user.tweets.create(:content => params[:content])
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    end

    get '/tweets/:id' do
      if logged_in?
        @tweet = Tweet.find_by(:id => params[:id])
        erb :'tweets/show_tweet'
      else
        redirect '/login'
      end
    end

    post '/tweets/:id' do

    end

    get '/tweets/:id/edit' do

    end

    post 'tweets/:id/delete' do

    end
end
