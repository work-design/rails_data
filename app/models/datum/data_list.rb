module Datum
  class DataList < ApplicationRecord
    include Model::DataList
    include Com::Ext::Parameter
  end
end
