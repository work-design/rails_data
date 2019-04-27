class RecordList < ApplicationRecord
  include RailsData::RecordList
end unless defined? RecordList
