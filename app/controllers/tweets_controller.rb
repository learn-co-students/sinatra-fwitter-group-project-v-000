class TweetsController < ApplicationController
  get '/tweets' do
    # "please work"
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end
  #creating a new tweet
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  post '/tweets' do
    if logged_in?
      if params[:content].empty?
        redirect '/tweets/new'
      else
        @user = User.find_by(:id => session[:user_id])
                # binding.pry
        @tweet = Tweet.create(content: params[:content], user_id: @user.id)

        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      # binding.pry
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :"/tweets/edit"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  patch '/tweets/:id' do
    if logged_in?
      if params[:content].empty?
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(:content => params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
          redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect to '/tweets'
        end
      end
    else
      redirect '/login'
    end
  end
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      # binding.pry
      if @tweet && @tweet.user == current_user
        @tweet.destroy
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
