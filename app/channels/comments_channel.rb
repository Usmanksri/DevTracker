class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'comments_channel'
    puts "Sub !!!!!!!!!!"

  end

  def unsubscribed
    puts "Unsub !!!!!!!!!!"
    # Clean up any necessary resources or actions when the channel is unsubscribed
  end
  #byebug
  def received(data)
    puts "Received!!!!!!!!!!!:"
    # Handle the received data as needed
  end

end
