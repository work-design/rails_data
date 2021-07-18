module Datum
  class TableList < ApplicationRecord
    include Model::TableList
    include Service::Import
  end
end
