class TheData::BaseController < ApplicationController
  include TheRole::Controller

  layout 'the_data'
  before_action :require_role

  helper_method :the_role_user

  def the_role_user
    current_user&.employee
  end

end
