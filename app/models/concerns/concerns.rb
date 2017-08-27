module Concerns

  module InstanceMethods

    def slug
     self.username.parameterize
    end

  end

  module ClassMethods

    def find_by_slug(slug)
      self.all.find {|s| s.slug == slug }
    end

  end

  module HelperMethods

    private

    def current_user(session_hash)
      User.find_by_id(session_hash[:user_id])
    end

    def is_logged_in?(session_hash)
      !!session_hash[:user_id]
    end

  end

end
