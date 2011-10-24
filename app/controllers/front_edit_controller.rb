class FrontEditController < ::ApplicationController

  layout false

  CSS_DIR = Rails.root + 'public/stylesheets/**/*.css'
  JS_DIR = Rails.root + 'public/javascripts/**/*.js'


  def index
    @source_path = Rails.root + params[:file]
    @source = File.read @source_path
  end

  def update
    @path = params[:file]
    n = params[:source].gsub(/\r\n/, "\n")
    File.open(@path, 'w') {|f| f.write(n)}

    # git commit

    `git add #{@path}`
    edit_msg = !params[:edit_message].blank? ? params[:edit_message] : "unspecified edit"

    author = (session[:commit_author] = params[:commit_author])
    if session[:commit_author].blank?
      flash.now[:notice] = "Edited By must not be blank"
      @source = params[:source]
      render :action => 'index'
      return
    end
    `git commit --author='#{author}' -m '#{edit_msg}' #{@path}`

    params.delete(:source)
    flash[:notice] = "#@path updated"
    redirect_to :action => 'index', :file => params[:file]
  end
end
