module Datum
  class ExportItem < ApplicationRecord
    include Model::TemplateItem
    include Com::Ext::Extra
  end
end
