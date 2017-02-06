class DoneChannel < ApplicationCable::Channel

  def subscribed
    stream_from "user:#{current_user_id}"
  end

end
