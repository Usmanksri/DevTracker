import consumer from "channels/consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    console.log("Connected");
  },

  disconnected() {
    console.log("Disconnected");
  },

  received(data) {
    console.log("Received data:", data);  }
});
