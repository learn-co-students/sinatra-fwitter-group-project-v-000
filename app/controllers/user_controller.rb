require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

    get '/signup' do
    #  @session = session
#binding.pry
          if logged_in?
              redirect '/tweets'
          else
              erb :"/users/create_user"
          end

    end

    post '/signup' do
                  if params[:username]=="" || params[:email]=="" || params[:password]==""
                       flash[:message] = "Do not leave Username/Email/Password sections blank."
                        redirect to '/signup'
                          #GREAT CODE BELOW FOR ADDITIONAL VALIDATIONS, BUT MESSES UP RSPEC TCS
                                  #  elsif  !!User.find_by(username: params[:username])
                                  #        flash[:message] = "This username has already been taken. Please makeup a new username."
                                  #         redirect to '/signup'
                                  # elsif  !!User.find_by(email: params[:email])
                                  #         flash[:message] = "This email has already been taken. Please use a new email."
                                  #        redirect to '/signup'
                  else

                      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
                      session[:user_id] = @user.id
#binding.pry
                      redirect '/tweets'
                  end

    end
    get '/login' do
#binding.pry
      if logged_in?
          redirect '/tweets'
      else
          erb :"/users/login"
      end
    end
    post '/login' do

        @user = User.find_by(username: params[:username])
#binding.pry
        if @user && @user.authenticate(params[:password])
              session[:user_id] = @user.id
              redirect to '/tweets'
        else

              redirect '/login'
              flash[:alert] = "Your username/password was Incorrect. If you need to register a new account please visit the Signup page."
              #flash currently not working
        end
    end
    get '/logout' do
      session.clear
      redirect to "/login"
    end
    get '/users/:slug' do

          @user = current_user
#binding.pry
          erb :'/users/show'

    end


end


# =>        rspec spec/controllers/application_controller_spec.rb
