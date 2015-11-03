require 'active_support/concern'
module TheData

  module Combine
    extend ActiveSupport::Concern

    included do
      belongs_to :combine, dependent: :destroy
    end

  end

end
