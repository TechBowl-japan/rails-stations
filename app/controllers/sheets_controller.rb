class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all
    @sheet_row_a = Sheet.all.limit(5)
    @sheet_row_b = Sheet.all.limit(5).offset(5)
    @sheet_row_c = Sheet.all.limit(5).offset(10)
  end
end