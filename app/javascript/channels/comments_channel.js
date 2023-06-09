import consumer from "channels/consumer";

document.addEventListener('DOMContentLoaded', () => {
  const notificationNavItem = document.querySelector('.navbar-item-right .notification');
  const notification = document.querySelector('.notification');

  const getNotificationCountFromStorage = () => {
    const notificationCount = sessionStorage.getItem('notificationCount');
    return notificationCount ? parseInt(notificationCount) : 0;
  };

  const setNotificationCountInStorage = (count) => {
    sessionStorage.setItem('notificationCount', count.toString());
  };


  const updateNotificationCounts = (count) => {
    notificationNavItem.textContent = count.toString();
    notification.textContent = count.toString();
  };

  let count = getNotificationCountFromStorage();
  updateNotificationCounts(count);

  consumer.subscriptions.create("CommentsChannel", {
    connected() {
      console.log("Connected");
    },

    disconnected() {
      console.log("Disconnected");
    },

    received(data) {
      console.log("Received data:", data);
      count++; 
      updateNotificationCounts(count);

      setNotificationCountInStorage(count);
    }
  });
});

