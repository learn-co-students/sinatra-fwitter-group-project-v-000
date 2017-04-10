class UsersController < ApplicationController

  # CREATE

  get "/signup" do # Replacement for "/users/new"
    @flash_message = session[:flash] if session[:flash]
    session[:flash] = nil
    if UserHelper.logged_in?(session)
      redirect "/tweets"
    else
      erb :'/users/new'
    end
  end

  post "/signup" do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect "/tweets"
    else
      session[:flash] = "Please fill in all fields"
      redirect "/signup"
    end
  end

  # READ

  get "/users" do
    @users = User.all
    erb :'/users/index'
  end

  get "/users/:slug" do
    @user = User.all.detect{|user| user.slug == params[:slug]}
    @current_user = UserHelper.current_user(session)
    erb :'/users/show'
  end

  # UPDATE

  get "/edit_profile" do # "/users/:id/edit" (must validate session ID)
    if UserHelper.logged_in?(session)
      @flash_message = session[:flash] if session[:flash]
      session[:flash] = nil
      @current_user = UserHelper.current_user(session)
      erb :'/users/edit'
    else
      redirect "/"
    end
  end

  patch "/users/:id" do
    @current_user = UserHelper.current_user(session)
    if @current_user.update(params[:user])
      redirect "/users/#{@current_user.slug}"
    else
      session[:flash] = "Please fill in all fields"
      redirect "/edit_profile"
    end
  end

  # DELETE

  delete "/delete_account" do # (must validate session ID)

  end

end
