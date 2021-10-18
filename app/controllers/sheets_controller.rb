class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all
  end
end
