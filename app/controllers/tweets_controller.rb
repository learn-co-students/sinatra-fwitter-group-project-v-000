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
      redirect '/#{@user.slug}/tweets'
    else
      redirect '/tweets'
    end
  end


end
