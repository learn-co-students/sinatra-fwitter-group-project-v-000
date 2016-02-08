require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'billy'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    end
      erb :signup
  end

  post '/signup' do
    @user = User.find_or_create_by(username: params['username'], email: params['email'], password: params['password'])
    if @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:id] == nil
      erb :login
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params['username'], password: params['password'])
    session[:id] = @user.id
    redirect '/tweets'
  end

  get '/tweets' do
    if is_logged_in?(session)
      @user = current_user(session)
      @tweets = Tweet.all
      erb :tweets
    else
      redirect '/login'
    end

  end

  get '/logout' do
    if is_logged_in?(session)
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params(:slug))
    erb :show
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      @user = current_user(session)
      erb :newtweet
    else
      redirect '/login'
    end
  end

  post '/newtweet' do
    if params["content"] != ""
      @newtweet = Tweet.new(content: params['content'])
      @newtweet.user_id = current_user(session).id
      @newtweet.save
      redirect "/tweets/#{@newtweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params["id"])
      erb :showtweet
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params["id"])
      erb :edittweet
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params["id"])
    @tweet.content = params["content"]
    @tweet.save
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params["id"])
    if is_logged_in?(session) && current_user(session).id == @tweet.user_id
      @tweet.destroy
      redirect '/tweets'
    elsif is_logged_in?(session)
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end


#helpers
def current_user(session)
  User.find(session[:id])
end

def is_logged_in?(session)
  !!session[:id]
end



