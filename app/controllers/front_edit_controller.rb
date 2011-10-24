class FrontEditController < ::ApplicationController
  layout false

  CSS_DIR = Rails.root + 'public/stylesheets/**/*'
  JS_DIR = Rails.root + 'public/javascripts/**/*'


  def index
    file = params[:file]
    @source_path = Rails.root + file
    @source = File.read @source_path
    @css = Dir[CSS_DIR].entries.map {|x| FrontEdit.rel_path(x)}
    @js = Dir[JS_DIR].entries.map {|x| FrontEdit.rel_path(x)}
  end
end
