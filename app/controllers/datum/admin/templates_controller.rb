module Datum
  class Admin::TemplatesController < Admin::BaseController

    private
    def template_params
      result = params.fetch(:template, {}).permit(
        :name,
        :file,
        parameters: {}
      )
      result['parameters'] = result['parameters'].values.each_with_object({}) { |i, h|  h.merge! i['column'] => i['value'] }
      result
    end

  end
end
