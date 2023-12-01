# frozen_string_literal: true

module Datum
  module Controller::Admin
    extend ActiveSupport::Concern
    include Roled::Controller::Admin

    included do
      skip_before_action :require_user if whether_filter(:require_user)
    end

  end
end
