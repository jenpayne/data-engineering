class DataImportsController < ApplicationController

  def index
    @gross_revenue = params[:gross_revenue]
    @error_msg = params[:error_msg]
  end

  def import
    file = params[:file]
    begin
      data_import = DataImport.new(file)
      data_import.process
      gross_revenue = data_import.calculate_revenue
      redirect_to root_url(gross_revenue: gross_revenue)
    rescue Exception => e
      redirect_to root_url(error_msg: "There was a problem importing the file: #{e.message}")
    end
  end
end