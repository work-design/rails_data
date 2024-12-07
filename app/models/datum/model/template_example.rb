module Datum
  module Model::TemplateExample
    extend ActiveSupport::Concern

    included do
      attribute :fields, :json
      attribute :position, :integer

      belongs_to :template
    end

  end
end
