module Slugifiable

  def slug
    self.username.split(" ").map { |name| name.downcase }.join("-")
  end

end
