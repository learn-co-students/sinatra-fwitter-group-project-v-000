require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if !session[:id]
      erb :'users/create_user'
    else
      redirect '/tweets'
    end
  end

  get '/login' do 
    if !session[:id]
      erb :'users/login'
    else 
      redirect '/tweets'
    end
  end

  post '/login' do 
    user = User.find_by(:username => params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end

  end

 
 


  get '/tweets/new' do
    if session[:id]
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end   
  end

   get '/tweets' do
    if session[:id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end   
  end


  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      user = User.find(session[:id])
      @tweet = Tweet.create(:content => params[:content], user_id: user.id)
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  

   get '/users/:slug' do 
      @user = User.find_by(name: User.unslug(params[:slug]))
      erb :'users/show'
   end


  get '/logout' do
    if session[:id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/tweets' do 
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end



  post '/signup' do     
   
    @user = User.new(params[:user])

    if @user.save
      session[:id] = @user.id 
      redirect '/tweets'

    elsif 
      redirect '/signup'
    end
  end


   get '/tweets/:id/edit' do
    if session[:id] 
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == session[:id]
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

    get '/tweets/:id' do 
    if session[:user_id]
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else 
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do 
    if params[:content] == ""
      redirect to "/tweets/#{params[:id]}/edit"
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end


   delete '/tweets/:id/delete' do 
    @tweet = Tweet.find(params[:id])
    if session[:id]
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:id]
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
   

end