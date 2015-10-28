require 'active_support/concern'
module TheData

  module Combine
    extend ActiveSupport::Concern

    included do
      has_one :combine, as: :reportable, dependent: :destroy
      has_many :combines, as: :reportable, dependent: :destroy
    end

  end

end
