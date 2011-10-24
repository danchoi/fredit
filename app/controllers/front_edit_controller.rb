class FrontEditController < ::ApplicationController

  def index

    file = params[:file]
    @source_path = Rails.root + file
    @source = File.read @source_path

  end
end
