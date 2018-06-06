class TweetsController < ApplicationController

  configure do
  enable :sessions
  set :session_secret, "secret"
end

end
