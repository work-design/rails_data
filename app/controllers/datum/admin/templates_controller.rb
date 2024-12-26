module Datum
  class Admin::TemplatesController < Admin::BaseController
    before_action :set_new_template, only: [:new, :create]
    before_action :set_template, only: [:show, :edit, :update, :destroy]

    private
    def set_new_template
      @template = Template.new(template_params)
    end

    def set_template
      @template = Template.find params[:id]
    end

    def template_params
      result = params.fetch(:template, {}).permit(
        :name,
        :file,
        :uploaded_at,
        parameters: {}
      )
      result['parameters'] = result['parameters'].values.each_with_object({}) { |i, h|  h.merge! i['column'] => i['value'] } if result['parameters']
      result
    end

  end
end
