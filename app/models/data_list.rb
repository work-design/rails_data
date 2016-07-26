class DataList < ActiveRecord::Base
  serialize :parameters, Hash
  has_many :table_lists, dependent: :destroy
  has_many :table_items, through: :table_lists
  scope :published, -> { where(published: true) }

  before_save :update_parameters

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