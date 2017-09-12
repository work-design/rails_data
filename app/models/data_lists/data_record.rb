class DataRecord < DataList
  has_many :record_lists, foreign_key: 'data_list_id', dependent: :destroy
  has_many :record_items, through: :record_lists


  before_create :set_columns


  def set_columns
    config_table.config_column
  end
  
end