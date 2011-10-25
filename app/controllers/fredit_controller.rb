require 'shellwords'

class FreditController < ::ApplicationController

  layout false

  CSS_DIR = Rails.root + 'public/stylesheets/**/*.css'
  JS_DIR = Rails.root + 'public/javascripts/**/*.js'

  def index
    @path ||= secure_path(params[:file] || params[:new_path] || Fredit.editables[:views].first)
    if !File.size?(@path)
      File.open(@path, 'w') {|f| f.write("REPLACE WITH CONTENT")}
    end
    @source = File.read(Rails.root + @path)
  end

  def update
    @path = secure_path params[:file_path]

    edit_msg = !params[:edit_message].blank? ? Shellwords.shellescape(params[:edit_message].gsub(/["']/, '')) : "unspecified edit"

    session[:commit_author] = (params[:commit_author] || '').gsub(/['"]/, '')
    author = session[:commit_author]
    if session[:commit_author].blank?
      flash.now[:notice] = "Edited By must not be blank"
      @source = params[:source]
      render :action => 'index'
      return
    end

    if params[:commit] =~ /delete/i
      `git rm #@path`
      flash[:notice] = "#@path deleted"
      res = system %Q|git commit --author='#{author}' -m '#{edit_msg}' #{@path}|
      @path = nil
    else
      n = params[:source].gsub(/\r\n/, "\n")
      File.open(@path, 'w') {|f| f.write(n)}
      system %Q|git add #{@path}|
      flash[:notice] = "#@path updated"
      res = system %Q|git commit --author='#{author}' -m '#{edit_msg}' #{@path}|
    end
    if res == false
      flash[:notice] = "Something went wrong with git. Make sure you changed something and filled in required fields."
    end
    params.delete(:source)

    redirect_to :action => 'index', :file => @path
  end
  
  def create
    @path = secure_path params[:file]
    FileUtils::mkdir_p File.dirname(@path)
    File.open(@path, 'w') {|f| f.write("REPLACE WITH CONTENT")}
  end

private

  def secure_path(path)
    path2 = File.expand_path(path.to_s)
    if path2.index(Rails.root.to_s) != 0
      raise "Unauthorized path: #{path2} (Raw: #{path})"
    end
    path
  end

end
