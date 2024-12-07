module Datum
  module Model::Validation
    extend ActiveSupport::Concern

    included do
      attribute :header, :string
      attribute :fields, :json

      belongs_to :template
    end

  end
end
