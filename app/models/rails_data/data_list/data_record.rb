module RailsData::DataList::DataRecord
  extend ActiveSupport::Concern
  included do
    has_many :record_lists, foreign_key: 'data_list_id', dependent: :destroy
    has_many :record_items, through: :record_lists
  end
  
  def rebuild!
    self.columns = self.config_params
    super
  end

  def update_parameters
    self.columns = config_columns
  end

  def config_columns
    config_table.columns.transform_values { |x| x[:as] }
  end

end
