module Datum
  class DoneChannel < ApplicationCable::Channel

    def subscribed
      stream_from "done:#{current_receiver.class.base_class.name}:#{current_receiver.id}" if current_receiver
    end

    def unsubscribed
    end

  end
end
