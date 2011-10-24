class FrontEditController < ::ApplicationController

  layout false

  CSS_DIR = Rails.root + 'public/stylesheets/**/*.css'
  JS_DIR = Rails.root + 'public/javascripts/**/*.js'

  def index
    @path ||= FrontEdit.editables[:views].first
    @source = File.read(Rails.root + @path)
  end

  def update
    @path = params[:file_path]

    edit_msg = !params[:edit_message].blank? ? params[:edit_message] : "unspecified edit"

    author = (session[:commit_author] = params[:commit_author])
    if session[:commit_author].blank?
      flash.now[:notice] = "Edited By must not be blank"
      @source = params[:source]
      render :action => 'index'
      return
    end

    if params[:commit] =~ /delete/i
      `git rm #@path`
      flash[:notice] = "#@path deleted"
      `git commit --author='#{author}' -m '#{edit_msg}' #{@path}`
      @path = nil
    else
      n = params[:source].gsub(/\r\n/, "\n")
      File.open(@path, 'w') {|f| f.write(n)}
      `git add #{@path}`
      flash[:notice] = "#@path updated"
      `git commit --author='#{author}' -m '#{edit_msg}' #{@path}`
    end
    params.delete(:source)

    redirect_to :action => 'index', :file => @path
  end
  
  def create
    @path = params[:file]
    File.open(@path, 'w') {|f| f.write("REPLACE WITH CONTENT")}
  end

end
