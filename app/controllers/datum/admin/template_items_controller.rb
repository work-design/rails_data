module Datum
  class Admin::TemplateItemsController < Admin::BaseController
    before_action :set_template
    before_action :set_new_template_item, only: [:new, :create]

    def index
      @template_items = @template.template_items.page(params[:page])
    end

    private
    def set_template
      @template = Template.find params[:template_id]
    end

    def set_new_template_item
      @template_item = @template.template_items.build(template_item_params)
    end

    def template_item_params
      result = params.fetch(:template_item, {}).permit(
        extra: {}
      )
      result[:extra].compact_blank! if result[:extra]
      result
    end

  end
end
