class TweetsController < ApplicationController

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
      erb :index
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if Helpers.logged_in?(session)
      if !params[:tweet][:content].empty?
        tweet = Tweet.create(params[:tweet])
        tweet.user_id = session[:user_id]
        tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?(session)
      @tweet = Tweet.find(params[:id])
      if @tweet.user == Helpers.current_user(session)
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if Helpers.logged_in?(session)
      tweet = Tweet.find(params[:id])
      if !params[:tweet][:content].empty?
        tweet.content = params[:tweet][:content]
        tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect "/tweets/#{tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if Helpers.logged_in?(session)
      tweet = Tweet.find(params[:id])
      if tweet.user == Helpers.current_user(session)
        tweet.destroy
      end
        redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
