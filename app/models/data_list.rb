class DataList < ActiveRecord::Base
  serialize :parameters, Hash
  has_many :table_lists, dependent: :destroy
  has_many :table_items, through: :table_lists
  scope :published, -> { where(published: true) }

  before_save :update_parameters

  def clear_old
    self.done = false
    self.remove_file = true
    self.save
    table_lists.delete_all

    self.remove_file = nil
  end

  def add_to_worker
    TableWorker.perform_async(self.id)
  end

  def table_items_count
    table_lists.sum(:table_items_count)
  end

  def published_value
    published ? 'published' : 'unpublished'
  end

  def update_parameters
    self.parameters = config_params
  end

  def config_params
    klass = data_table.to_s.constantize
    params = {}
    if klass
      klass.instance_method(:config).parameters.each do |param|
        params.merge! param[1] => param[0]
      end
    end
    params
  end

end