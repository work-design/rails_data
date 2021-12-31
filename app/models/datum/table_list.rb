module Datum
  class TableList < ApplicationRecord
    include Model::TableList
    include Service::Import
    include Com::Ext::Extra
  end
end
