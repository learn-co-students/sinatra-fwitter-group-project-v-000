class TweetController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/tweets' do
    if session[:id]
      @user = User.find_by(id: session[:id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if session[:id]
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    @user = User.find_by(id: session[:id])
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user = @user
      @tweet.save
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if session[:id]
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if session[:id]
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user.id == session[:id]
        erb :'tweets/edit_tweet'
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content] != ""
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if session[:id] && @tweet.user.id == session[:id]
      @tweet.delete
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

end
