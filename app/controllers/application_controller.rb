require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "whatevs"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user=User.find_by(email: params["user"]["email"])
    if @user && @user.authenticate(params["user"]["password"])
      session[:id]=@user[:id]
      redirect '/tweets'
binding.pry
    else
      erb :failure
    end
  end

  get '/signup' do
# binding.pry
    if is_logged_in
# binding.pry
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
# binding.pry
    if is_logged_in
binding.pry
      redirect '/tweets'
    elsif params.any?{|k,v| v==""}
# binding.pry 
      redirect '/signup'
# binding.pry
    else
# binding.pry
      @user=User.new(params)
  # binding.pry
      if @user.save
  # binding.pry
        session[:id]=@user.id
        redirect '/tweets'
      end
    end

  end


  get '/tweets' do
    if is_logged_in
      @user=current_user
      erb :'tweets/tweets'
    else
      erb :failure, :locals=>{:message=>"You must be logged in to do that."}
    end
  end

  get '/tweets/new' do
    if is_logged_in
      @user=current_user
      erb :'tweets/create_tweet'
    else
      erb :failure, :locals=>{:message=>"You must be logged in to do that."}
    end
  end

  post '/tweets' do
    
    if session[:id]=params["user"]["id"]
      @tweet=Tweet.new(content: params["user"]["tweet"])
      @tweet.user_id=session[:id]
      @tweet.save
      erb :'tweets/show_tweet'
    else
      erb :failure, :locals=>{:message => "You must be logged in to do that"}
    end
  end

  get '/tweets/:id' do
    @tweet=Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet=Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do
    
# binding.pry
    @tweet=Tweet.find(params[:id])
    @tweet.content=params["new_content"]
# binding.pry
    @tweet.save

    redirect "/tweets/#{@tweet.id}"
    
  end

  delete '/tweets/:id/delete' do
# binding.pry
    @tweet=Tweet.find(params[:id])
    @tweet.delete

    redirect "/tweets"

  end

  get '/logout' do
    session.clear
    redirect '/'
  end


  get '/home' do
    if is_logged_in
      @user=current_user
      erb :index
    else
      redirect '/'
    end
  end

  helpers do 
          def current_user
            User.find(session[:id])
          end

          def is_logged_in
# binding.pry
            !!session[:id]
          end

          def taken?
            !User.where(params["user"]["email"]).empty?
          end
  end
end