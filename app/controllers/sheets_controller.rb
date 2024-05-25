class SheetsController < ApplicationController
  def index
    @sheets_by_row = Sheet.all.group_by(&:row)
    @columns = Sheet.all.pluck(:column).uniq.sort
  end
end
