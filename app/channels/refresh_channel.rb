class RefreshChannel < ApplicationCable::Channel
  def subscribed
     stream_from "refresh_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
