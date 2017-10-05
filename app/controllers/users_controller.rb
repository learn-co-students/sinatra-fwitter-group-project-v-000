class UsersController < ApplicationController

get '/signup' do
  if session[:user_id]
    redirect '/tweets'
  else
    erb :'users/create_user'
  end
end

post '/signup' do
  if params[:username] == "" || params[:email] == "" || params[:password] == ""
    redirect '/signup'
  else
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect '/tweets'
  end
end

end
