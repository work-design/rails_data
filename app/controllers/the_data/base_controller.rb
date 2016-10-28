class TheData::BaseController < ApplicationController
  include TheRole::Controller

  layout 'admin'
  before_action :require_role

end
