module UserHelpers
  def validate_new_user_params(params)
    params.none? {|key, value| value == ""}
  end
end

