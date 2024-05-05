class SheetsController < ApplicationController
    def index
      @sheets = Sheet.all.order(:row, :column)
    end
  end