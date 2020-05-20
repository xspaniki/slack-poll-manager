class PollChannel < ApplicationCable::Channel
  def subscribed
    stream_for poll
  end

  def unsubscribed
  end

  private

  def poll
    Poll.find(params[:poll_id])
  end
end
