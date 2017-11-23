module Validate
  module InstanceMethods
    def user_params_blank?(params)
      return true if params[:username] == nil || params[:username] == "" ||
          params[:email] == nil || params[:email] == "" ||
          params[:password] == nil || params[:password] == ""
      end
  end
end
