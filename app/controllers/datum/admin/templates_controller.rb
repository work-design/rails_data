module Datum
  class Admin::TemplatesController < Admin::BaseController

    def show
      @template = Template.find params[:id]

      respond_to do |format|
        format.html
        format.turbo_stream
        format.xlsx { send_data @template.export, filename: "#{@template.name}.xlsx", type: 'application/xlsx' }
      end
    end

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
