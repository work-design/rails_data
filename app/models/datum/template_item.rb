module Datum
  class TemplateItem < ApplicationRecord
    include Model::TemplateItem
    include Com::Ext::Extra
  end
end
