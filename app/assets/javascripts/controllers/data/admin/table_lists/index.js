//= require action_cable
//= require_self
//= require channels/done

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer('/cable');

}).call(this);