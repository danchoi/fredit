require 'git'

class FreditController < ::ApplicationController

  layout 'fredit'

  before_filter :load_git

  CSS_DIR = Rails.root + 'public/stylesheets/**/*.css'
  JS_DIR = Rails.root + 'public/javascripts/**/*.js'

  def show
    @path ||= secure_path(params[:file] || Fredit.editables[:views].first)
    @source = File.read(Rails.root + @path)
  end

  def update
    @path = secure_path params[:file_path]

    edit_msg = !params[:edit_message].blank? ? params[:edit_message] : "unspecified edit"
    edit_msg_file = Tempfile.new('commit-message')
    t.write(edit_msg) # we write this message to a file to protect against shell injection
    t.cloase

    session[:commit_author] = (params[:commit_author] || '')
    # cleanup any shell injection attempt characters
    author = session[:commit_author].gsub(/[^\w@<>. ]/, '') 

    if session[:commit_author].blank?
      flash.now[:notice] = "Edited By must not be blank"
      @source = params[:source]
      render :action => 'show'
      return
    end

    if params[:commit] =~ /delete/i
      `git rm #@path`
      flash[:notice] = "#@path deleted"
      res = system %Q|git commit --author='#{author}' --file '#{edit_msg_file}' #{@path}|
      @path = nil
    else
      n = params[:source].gsub(/\r\n/, "\n")
      File.open(@path, 'w') {|f| f.write(n)}
      system %Q|git add #{@path}|
      flash[:notice] = "#@path updated"
      res = system %Q|git commit --author='#{author}' --file '#{edit_msg_file}' #{@path}|
    end
    if res == false
      flash[:notice] = "Something went wrong with git. Make sure you changed something and filled in required fields."
    end
    redirect_to fredit_path(:file => @path)
  end
  
  def create
    @path = secure_path params[:new_file]
    FileUtils::mkdir_p File.dirname(@path)
    File.open(@path, 'w') {|f| f.write("REPLACE WITH CONTENT")}
    flash[:notice] = "Created new file: #@path"
    redirect_to fredit_path(:file => @path)
  end

private

  def load_git
    @git = Git.init Rails.root
  end

  def secure_path(path)
    path2 = File.expand_path(path.to_s)
    if path2.index(Rails.root.to_s) != 0
      raise "Unauthorized path: #{path2} (Raw: #{path})"
    end
    path
  end

end
