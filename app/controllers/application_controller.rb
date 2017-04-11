require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "steal3th*s1pa ssword4secret1"
  end

  get '/' do
    erb :index
  end

  get '/signup' do #creates user unless user already logged in; otherwise redirects.
    logged_in? ? (redirect '/tweets') : (erb :'/users/create_user')
  end

  post '/signup' do #signs up a user and redirects to index (/tweets) if successful, else loops back to signup page.
    redirect '/signup' if params.any? {|param| param[1].empty?} #not convinced this is more readable, but it did save space.
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    logged_in? ? (redirect '/tweets') : (erb :'/users/login')
  end

  post '/login' do
    redirect '/login' if params[:username].empty? || params[:password].empty?
    @user = User.find_by(username: params[:username]) #find and set user (if possible)
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
  end
end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets' do #loads tweet page
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @tweets = @user.tweets
      erb :'/tweets/tweets'
    end
  end

  get '/tweets/new' do #try a lambda instead of unless (and definitely instead of else/if)
    if !logged_in?
      redirect '/login'
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets/new' do
    #binding.pry
    unless params[:content].empty?
      @user = current_user
      @tweet = Tweet.create(params) #later change to .new
      @tweet.user_id = @user.id
      @tweet.save
      #redirect '/tweets'
    end
  end

  get "/users/:slug" do
    @user = find_by_slug(params[:slug])
    erb :"/tweets/show_tweet"
  end

  get "/tweets/:id" do
    #binding.pry
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post "/tweets/:id" do
    
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect :'/show_tweet'
  end

    # context 'logged in' do
    #   it 'displays a single tweet' do
    #     visit "/tweets/#{tweet.id}"
    #     expect(page.status_code).to eq(200)
    #     expect(page.body).to include("Delete Tweet")
    #     expect(page.body).to include(tweet.content)
    #     expect(page.body).to include("Edit Tweet")
    #   end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in? #dunno if this should be a class method
      !!session[:user_id]
    end
  end
end
