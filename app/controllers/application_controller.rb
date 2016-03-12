require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'yaaaaaaaaaaaaaaaaaaaaas_queeeeeeeeeeen'
  end

  # Fwitter Homepage
  get '/' do
    erb :index
  end

  ############# TWEETS #####################

  # READ
  get '/tweets' do #all tweets
     if is_logged_in? #if person is logged in...
      @tweets = Tweet.all # get all the tweets
      erb :'tweets/tweets'
    else
      redirect to '/login' #if not, have them log in
    end
  end

  # CREATE
  get '/tweets/new' do #goes to create page/form
    if is_logged_in?
      erb :'tweets/create_tweet' #allow them to create a tweet if they are logged in
    else
      redirect to '/login'
    end
  end

  post '/tweets' do #takes params from the form
    if params[:content] == '' #no blank tweets allowed. descriptive error message would be nice
      redirect to 'tweets/new'
    else
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(content: params[:content], user_id: user.id) #make that tweet
      redirect to "/tweets/#{@tweet.id}" #don't use '' for string interpolation
    end
  end

  # READ
  get '/tweets/:id' do  #get tweets/id should come after get tweets/new
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])   #if logged in, find the tweet & show the tweet
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  # UPDATE / EDIT
    get '/tweets/:id/edit' do  #edit comes after  get tweets/id
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])  #find the tweet
      if @tweet.user_id == session[:user_id] #check that the logged in user is the tweet owner
       erb :'tweets/edit_tweet'   #then allow them to edit
      else
        redirect to '/tweets'  #then take back to user's tweets
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    if params[:content] == '' #don't allow them update to a blank tweet
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find_by_id(params[:id]) #get the tweet
      @tweet.content = params[:content]  #change the content to params
      @tweet.save  #save the tweet to the db
      redirect to "/tweets/#{@tweet.id}" #show the tweet
    end
  end

  # DELETE
  delete '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])  #find that tweet
      if @tweet.user_id == session[:user_id] #check that the person is the creator
        @tweet.delete #destroy would work as well?
        redirect to '/tweets'  #back to main user page
      else
        redirect to '/tweets' #if they are logged in but not their tweet, they can't delete
      end
    else
      redirect to '/login'
    end
  end

  # See individual user's tweets don't have to be logged in
 get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  ################ USER ###############
  # User Sign up
  get '/signup' do #Displays user sign up page unless person is already logged in
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do #processes the signup form submission
    if params[:username] == "" || params[:email] == "" || params[:password] == "" # no empties allowed
      redirect to '/signup' #failure page or message would be nice
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save  #saves to DB
      session[:user_id] = @user.id #log them in
      redirect to '/tweets' #take them to their tweets
    end
  end

  # USER LOG IN
  get '/login' do #loads login page
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  post "/login" do   
    @user = User.find_by(username: params[:username]) #find the user
    if @user && @user.authenticate(params[:password]) #check password matches
      session[:user_id] = @user.id   #log them in
      redirect "/tweets" #show them some tweets
    else
      redirect "/login"
    end
  end

  # USER LOGOUT
  get '/logout' do
    if is_logged_in?
      session.clear   #logging out
      redirect '/login'
    else
      redirect '/'
    end
  end

  # Helpers
  def is_logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

end
