class UsersController < ApplicationController


get "/signup" do
  if !session[:user_id]
    erb :'users/create_user'
  else
    redirect to '/tweets'
  end
end


  post "/signup" do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to "/signup"
    else
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:session_id] = @user.id
      @user.save
    redirect to "/tweets"
    end
  end

  get "/login" do
    if !self.logged_in?
    erb :"users/login"
  else
    redirect to "/tweets"
  end
end


post '/login' do
   user = User.find_by(:username => params[:username])
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect "/tweets"
   else
     redirect to '/signup'
   end
 end




get '/logout' do
  session.clear
  redirect to "/login"
end


end
