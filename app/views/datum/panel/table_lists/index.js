import { createConsumer } from '@rails/actioncable'

ApplicationCable.subscriptions.create('DoneChannel', {
  received: function(data) {
    var c_id = '#done_' + data.done_id
    var collection = $(c_id)
    collection.html(data.body)
  },
  connected: function() {
    console.log('done channel connected success');
  }
})
