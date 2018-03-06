class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username]).authenticate(params[:password])

    if @user
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      logout
      redirect '/login'
    else
      redirect '/'
    end
  end

  # describe 'user show page' do
  #   it 'shows all a single users tweets' do
  #     user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
  #     tweet1 = Tweet.create(:content => "tweeting!", :user_id => user.id)
  #     tweet2 = Tweet.create(:content => "tweet tweet tweet", :user_id => user.id)
  #     get "/users/#{user.slug}"
  #
  #     expect(last_response.body).to include("tweeting!")
  #     expect(last_response.body).to include("tweet tweet tweet")
  #
  #   end
  # end

  get '/users/:slug' do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb:'/users/show'
  end

end
