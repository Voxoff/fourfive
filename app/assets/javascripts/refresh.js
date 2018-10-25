(function() {
  App.refresh = App.cable.subscriptions.create("RefreshChannel", {
    received: function(data) {
      console.log('In the loop')
      location.reload();
    }
  });
}).call(this);

// App.refresh = App.cable.subscriptions.create "RefreshChannel",
//   received: (data) -> 
//     console.log("Coffee")
