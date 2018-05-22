require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  ## Main Views ##

  get '/' do
    erb :index
  end


  ## User Views ##

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.new(name: params["name"], email: params["email"], password: params["password"])
		if user.save
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
		else
      "FAILURE TO SAVE USER"
			# redirect to "/failure"
		end
  end


  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/users/#{user.id}"
    else
      "FAILURE TO FIND USER"
    end
  end


  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end


  get '/logout' do
    session.clear
    redirect to "/"
  end


  ## Tweet Views ##

  get '/tweets' do
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    puts "Params = #{params}"
    tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
    redirect to "/tweets/#{tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = tweet.find(params[:id])
    tweet.delete
    redirect to '/tweets'
  end


  ## Helpers ##

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end

# Referenced Labs
# playlister-sinatra-v-000 || sinatra-complex-forms-associations-v-000
# sinatra-secure-password-lab-v-000 || sinatra-user-auth-v-000
