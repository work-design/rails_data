module Datum
  module Model::Template
    extend ActiveSupport::Concern

    included do
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_one_attached :file
    end

  end
end
