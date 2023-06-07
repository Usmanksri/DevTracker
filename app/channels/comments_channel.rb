class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'comments_channel'
  end

  def unsubscribed
  end

  def received(data)
    puts "Received data: #{data}"
  end
end
