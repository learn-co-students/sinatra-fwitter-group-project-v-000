class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @tweets = Tweet.all
      @user = User.find_by(params[:user_id])
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = Helpers.current_user(session)
    if !@user
      redirect 'users/login'
    elsif !params[:tweet][:content].empty?
      @user.tweets << Tweet.create(content: params[:tweet][:content])
      @user.save
    else
      redirect '/tweets/new'
    end
    redirect '/tweets'
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    redirect 'user/login' unless Helpers.logged_in?(session)

      @tweet = Tweet.find_by_id(params[:id])

    if @tweet.user == Helpers.current_user(session)
      erb :'tweets/edit'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
    else
      redirect '/login'
    end
    erb :'tweets/show'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    redirect "/tweets/#{@tweet.id}/edit" unless !params[:tweet][:content].empty?

    @tweet.update(params[:tweet])
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user == Helpers.current_user(session)
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
