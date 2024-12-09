module Datum
  class ExportItem < ApplicationRecord
    include Model::ExportItem
    include Com::Ext::Extra
  end
end
