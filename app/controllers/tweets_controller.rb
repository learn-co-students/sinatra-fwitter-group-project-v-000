class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
  if logged_in?
    erb :'tweets/create_tweet'
  else
    redirect '/login'
  end
end

  post '/tweets' do
    @user = current_user
    if params[:content] != ""
      @user.tweets << Tweet.create(content: params[:content])
      redirect "/users/#{@user.slug}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end


end
