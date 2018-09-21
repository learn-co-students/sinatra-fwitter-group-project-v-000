class UsersController < ApplicationController
  get '/users/:slug' do
    @user = User.find_by(slug: params[:slug])
    if @user
      erb :"/users/show"
    else
      redirect '/'
    end
  end

  get '/users/:slug/edit' do
    erb :"/users/edit"
  end

  post '/users/:slug/edit' do
    redirect "/users#{params[:slug]}"
  end
end
