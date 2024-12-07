module Datum
  class Template < ApplicationRecord
    include Model::Template
    include Com::Ext::Parameter
  end
end
