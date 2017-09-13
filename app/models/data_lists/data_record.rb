class DataRecord < DataList
  has_many :record_lists, foreign_key: 'data_list_id', dependent: :destroy
  has_many :record_items, through: :record_lists


  def config_columns
    config_table.config_column.transform_values { |x| x[:type] }
  end

end