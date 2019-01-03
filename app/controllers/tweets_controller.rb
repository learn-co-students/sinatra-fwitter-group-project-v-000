class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
    @tweets = Tweet.all
    erb :'tweets/tweets'
  else
    redirect '/login'
  end
  end

  get '/tweets/new' do
    if logged_in?
    erb :'tweets/new'
  else
    redirect '/login'
  end
  end

  post '/tweets' do
    if params[:tweet][:content].length == 0
      redirect '/tweets/new'
    else
    @tweet = Tweet.create(params[:tweet])
    @tweet.user_id = current_user.id
    @tweet.save
    redirect :"/tweets/#{@tweet.id}"
  end
  end

  get '/tweets/:id' do
    if logged_in?
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/show_tweet'
  else
    redirect '/login'
  end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
     if params[:tweet][:content].length == 0
      redirect "/tweets/#{@tweet.id}/edit"
    else

    @tweet.update(params[:tweet])
    @tweet.save
    redirect :"/tweets/#{@tweet.id}"
  end
  end

  delete '/tweets/:id/delete' do #delete action
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to '/tweets'
  end


  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end



end
