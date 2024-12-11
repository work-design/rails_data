module Datum
  class Export < ApplicationRecord
    include Model::Export
    include Ext::Export
  end
end
