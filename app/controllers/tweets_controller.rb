class TweetsController < ApplicationController

  get '/tweets' do  
    if logged_in?
        @tweets = Tweet.all
        erb :'/tweets/tweets'
    else
        redirect '/login'
    end
  end

  get '/tweets/new' do
    #load create tweet form
    if User.current_user.logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect "/"
    end
  end

  get '/tweets/:id' do
    #individual show tweet page
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    #load form to edit tweet
    #find specific tweet from params[:id] to preload form
    @tweet = Tweet.find_by_id(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets' do
    #submit and catch the data and create new tweet object
    #redirect to individual tweet page
    @tweet = Tweet.create(content: params[:content])
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update = params[:content]
    redirect :'/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do
    #delete tweet by :id
    erb :'/index'
  end

end
