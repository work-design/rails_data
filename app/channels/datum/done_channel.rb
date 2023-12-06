module Datum
  class DoneChannel < ApplicationCable::Channel

    def subscribed
      stream_from "datum:done:#{verified_receiver.identity}"
    end

    def unsubscribed
    end

  end
end
