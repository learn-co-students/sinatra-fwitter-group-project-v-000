class TweetController < ApplicationController

  get '/tweets' do
    @tweet = Tweet.all
    if User.is_logged_in?(session)
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(params["tweet"])
    if params["content"].empty?
      redirect :'/tweets/new', locals: {message: "Your tweet was empty."}
    else
      erb :'/tweets/show_tweet', locals: {message: "Successfully created tweet."}
    end
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    if User.is_logged_in?(session)
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if User.is_logged_in?(session)
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets", locals: {message: "Tweet was successfully edited."}
    end
  end

  post '/delete' do
    
  end
end
