class TableJob


  def perform(table_list_id)
    @table_list = TableList.find(table_list_id)
    @table_list.run
  end

end
