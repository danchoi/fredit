class FrontEditController < ::ApplicationController

  layout false

  CSS_DIR = Rails.root + 'public/stylesheets/**/*.css'
  JS_DIR = Rails.root + 'public/javascripts/**/*.js'


  def index
    file = params[:file]
    @source_path = Rails.root + file
    @source = File.read @source_path
  end
end
