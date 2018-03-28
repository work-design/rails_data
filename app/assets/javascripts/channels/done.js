App.cable.subscriptions.create('DoneChannel', {
  received: function(data) {
    let c_id = '#done_' + data.done_id;
    let collection = $(c_id);
    collection.html(data.body);
  },
  connected: function() {
    console.log('done channel connected success');
  }
});
