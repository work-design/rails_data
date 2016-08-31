class DoneChannel < ApplicationCable::Channel

  def subscribed
    stream_from "user_#{current_user.id}"
  end

end
