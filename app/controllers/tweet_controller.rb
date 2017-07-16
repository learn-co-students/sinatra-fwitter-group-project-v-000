require './config/environment'

class TweetController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/tweets" do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      # binding.pry
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
      @user = User.find(session[:user_id])
      @slug = params[:slug]
      @show_user = User.find_by_slug(@slug)
      erb :'/users/show_user'
  end

  get '/tweets/new' do
     if logged_in?
         erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    # tweet = Tweet.new(content: params["content"])
    # if tweet.save
    #     current_user.tweets << tweet
    if current_user.tweets.create(content: params["content"]).valid?
        redirect to "/tweets"
    else
        redirect to "/tweets/new"
    end
  end

    get '/tweets/:tweet_id' do
     if logged_in?
        @tweet_id = params[:tweet_id]
        @tweet = Tweet.find_by(id: @tweet_id)
         erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

    get '/tweets/:tweet_id/edit' do
        if logged_in?
            @tweet_id = params[:tweet_id]
            @tweet = Tweet.find_by(id: @tweet_id)
            if @tweet.user_id == current_user.id
                erb :'/tweets/edit_tweet'
            else
                redirect "/tweets"
            end
        else
          redirect "/login"
        end
    end

    patch '/tweets/:tweet_id' do
        @tweet_id = params[:tweet_id]
        @tweet = Tweet.find_by(id: @tweet_id)
        if @tweet.user_id == current_user.id #Double check the user is authorized to send this patch request
            if @tweet.update(content: params["content"]) #If form is not empty
                redirect to '/tweets'
            else
                redirect to "/tweets/#{@tweet_id}/edit"
            end
        else
            redirect "/tweets"
        end
    end

    delete '/tweets/:tweet_id/delete' do
        if logged_in?
            @tweet_id = params[:tweet_id]
            @tweet = Tweet.find_by(id: @tweet_id)
            if @tweet.user_id == current_user.id
                @tweet.delete
            else
                redirect "/tweets"
            end
        else
          redirect "/login"
        end
    end

   helpers do
    def logged_in?
      !!current_user
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end #helpers

end