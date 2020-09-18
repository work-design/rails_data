class DataList < ApplicationRecord
  include RailsData::DataList
  include RailsComExt::Parameter
end unless defined? DataList
