class UsersController < Sinatra::Base
  get "/signup" do
    erb :"/users/create_user"
  end

  post "/signup" do
    if params[:username]== "" || params[:password] == "" || params[:email] ==""
      redirect "/signup"
    else
      User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      redirect '/tweets'
    end
  end
end
