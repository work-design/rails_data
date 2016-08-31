App.cable.subscriptions.create('DoneChannel', {
  received: function(data) {
    var c_id = '#done_' + data.done_id;
    var collection = $(c_id);
    collection.css('color', '#ff7f24');
    collection.html(data.body);
  },
  connected: function() {
    console.log('done channel connected success');
  }
});
