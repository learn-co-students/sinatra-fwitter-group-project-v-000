class TweetsController < ApplicationController

  get '/tweets' do
    if !!logged_in?
      @tweets = Tweet.all
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !!logged_in?
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    if !!logged_in?
      @user = current_user
        unless params[:content].blank?
          @user.tweets << Tweet.create(content: params[:content])
          redirect '/tweets'
        end
      else
      redirect '/tweets/new'
      end
  end




end
