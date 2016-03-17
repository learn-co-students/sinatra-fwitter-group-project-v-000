require './config/environment'

class TweetsController < Sinatra::Base
  include Helper

  configure do
    enable :sessions unless test?
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get '/tweets' do
    if !is_logged_in
      # redirect to '/signup'
      redirect to '/login'
    else
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if !is_logged_in
      redirect to '/login'
    else
      @user = current_user
      erb :'tweets/create_tweet'
    end
  end

  post '/tweets' do
    if !is_logged_in
      redirect to '/login'
    else
      @tweets = Tweet.create(user_id: current_user.id, content: params[:content])
      if @tweets.id.nil?
        redirect to '/tweets/new'
      else
        @user = current_user
        # erb :'tweets/tweets'
        redirect to "/tweets/#{@tweets.id}"
      end
    end
  end

  get '/tweets/:id' do
    @tweets = []
    if !is_logged_in
      redirect to '/login'
    end
    @tweets.push(Tweet.find(params[:id]))
    if @tweets.empty?
      redirect to '/tweets'
    end
    @user = current_user
    erb :'tweets/tweets'
  end

  get '/tweets/:id/edit' do
    if !is_logged_in
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    #redirect non-tweet owning users to /tweets
    if current_user.id != @tweet.user_id
      redirect to '/tweets'
    end
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    end
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect to "/tweets/#{params[:id]}"
  end

  delete '/tweets/:id/delete' do
    if !is_logged_in
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id != current_user.id
      redirect to '/tweets'
    end
    @tweet.destroy
    redirect to '/tweets'
  end

end
