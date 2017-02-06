# prepend this module
module TheDataConnection

  def self.prepended(model)
    model.identified_by :current_user_id
  end

  def connect
    self.current_user_id = session['user_id']
    super
  end

  protected
  def find_verified_user
    if session['user_id']
      current_user = User.find_by id: session['user_id']
    else
      current_user = nil
    end

    if current_user
      current_user
    else
      reject_unauthorized_connection
    end
  end

  def session
    session_key = Rails.application.config.session_options[:key]
    cookies.encrypted[session_key]
  end

end
