class TweetController < ApplicationController
	get '/tweets' do
    # binding.pry
    if session[:id]
      @user = current_user
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end
  end

  get '/tweets/:slug'

  get '/tweets/:id/edit' do
  end

  post '/tweets/:id' do
  	#update to tweets/id
  end

  post '/tweets/:id/delete' do
  	#deletion of tweet 
  end
end