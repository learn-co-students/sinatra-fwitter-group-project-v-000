require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'your_secret'
  end

  get '/' do
    erb :index
  end

  helpers do
      def logged_in?
        !!session[:user_id]
      end

      def current_user
        if logged_in?
          @current_user = User.find_by(id: session[:user_id])
        end
      end

      def login(user_id)
        session[:user_id] = user_id
      end

        # def logged_in?       !!session[:user_id]     end      def current_user       if logged_in?       @user = User.find(session[:user_id])       end     end      def login(user_id)       session[:user_id] = user_id     end      def logout       session.clear     end   end

    end



end
