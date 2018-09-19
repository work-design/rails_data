# prepend this module
module RailsDataConnection

  def self.prepended(model)
    model.identified_by :current_user
  end

  def connect
    self.current_user = find_verified_user
    super
  end

  protected
  # todo why session got nil
  def find_verified_user
    if session && session['user_id']
      User.find_by id: session['user_id']
    else
      logger.error 'An unauthorized connection attempt was rejected'
      nil
    end
  end

  def session
    session_key = Rails.application.config.session_options[:key]
    cookies.encrypted[session_key]
  end

end
