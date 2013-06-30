class SearchController < ApplicationController

  skip_filter :require_admin, :require_supervisor

  def index
  end

  def data
  end
end
