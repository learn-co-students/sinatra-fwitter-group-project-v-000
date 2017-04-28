class TweetController < ApplicationController
	get '/tweets' do
    # binding.pry
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      #flash message
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      #flash msg tweet successfully created
      redirect "/tweets/#{@tweet.id}"
    else
      #flast msg tweet cannot be empty
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

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
  	#update to tweets/id
  end

  post '/tweets/:id/delete' do
  	#deletion of tweet 
  end
end