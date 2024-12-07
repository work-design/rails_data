module Datum
  class Admin::TemplateItemsController < Admin::BaseController
    before_action :set_template

    def index
      @template_items = @template.template_items.page(params[:page])
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

  end
end
