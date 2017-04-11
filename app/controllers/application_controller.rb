require './config/environment'

class ApplicationController < Sinatra::Base #probably over-refactored this lab

  configure do
    # set :public_folder, 'public'
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

  post '/signup' do #signs up a user, creates and sets session to user.id, and redirects to index (/tweets) if successful, else loops back to signup page.
    redirect '/signup' if params.any? {|param| param[1].empty?} #Ensures no fields are blank. Not convinced this is more readable, but it did save space.
    @user = User.create(params)
    session[:user_id] = @user.id #creates session attribute :user_id and sets to @user.id until logout
    redirect '/tweets'
  end

  get '/login' do
    logged_in? ? (redirect '/tweets') : (erb :'/users/login')
  end

  post '/login' do
    redirect '/login' if params[:username].empty? || params[:password].empty?
    @user = User.find_by(username: params[:username]) #find and set user (if possible)
    if @user.authenticate(params[:password]) #create session (log user in) if supplied credentials are valid
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
  end
end

  get '/logout' do #logs user out and redirects to login page, otherwise redirects to homepage.
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets' do #sends user to login page if not logged in, else loads tweet page
    redirect '/login' if !logged_in?
    @user = current_user #provides erb access to user and user's tweets
    @tweets = @user.tweets
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do #Presents user with new tweet form, or sends them away if not logged in
    logged_in? ? (erb :'/tweets/create_tweet') : (redirect '/login')
  end

  post '/tweets/new' do #creates tweet from new tweet form post request unless it's blank.
    unless params[:content].empty?
      @tweet = Tweet.create(user_id: current_user.id, content: params[:content]) #creates new tweet using current_user object id and params
      redirect '/tweets'
    end
  end

  get "/users/:slug" do
    @user = find_by_slug(params[:slug])
    erb :"/tweets/show_tweet"
  end

  get "/tweets/:id" do #redirects to tweet edit URL, made necessary because I misunderstood that the spec didn't want edit/delete on the same page.
    logged_in? ? (redirect "/tweets/#{params[:id]}/edit") : (redirect "/login") #login check/redirect login is just to satisfy spec at this juncture
  end

  get "/tweets/:id/edit" do #finds tweet and renders edit page if the user is logged in, otherwise sends packing
    redirect '/login' unless logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post "/tweets/:id" do #Handles POST from tweet edit form and catches no-content exception
    @tweet = Tweet.find(params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty? #reloads page instead of saving tweet if tweet blank
    @tweet.update(content: params[:content]) #otherwise modifies and saves it as expected, then redirects to /tweets
    redirect '/tweets'
  end

  delete '/tweets/:id/delete' do #deletes tweet if if belongs to user, otherwise sends them away.
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in? #dunno if this should be a class method
      !!session[:user_id]
    end
  end
end
