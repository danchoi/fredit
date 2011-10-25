# fredit: front-end edit

fredit is a simple, no-frills Rails Engine that lets you edit your Rails
application's view templates, css stylesheets, and javascript files
(a.k.a front-end files) through the browser.

fredit injects an edit link into every view template. These edit links
are visible wherever the template is rendered, whether it is a layout,
a page, or a partial. 

By clicking on these links, you call up a edit page that will let you
directly edit the source, whether it is ERB, css, or javascript. An
update button lets you save these changes and alter the underlying
source files.

Stylesheets and javascript files are accessible through a file selection
drop down on the fredit edit page. 

You can also create and delete front-end files on the fredit edit page.


## Why fredit?



## Install

Put something like this in the Gemfile of your Rails app:

    group :staging do
      gem 'fredit'
    end
      
and then run `bundle install`.




## fredit's git workflow

fredit assumes that the Rails instance it is running on is a cloned git
repository. 

When you save your changes, fredit will make a git commit on
the git branch this instance of Rails application.

Clicking on fredit link will take you to a simple web-based editor where
you can directly edit the source of the view template.


## Template handler support

Currently only ERB template handlers are supported. You are welcome to
fork and add support for Haml and other templates.


commit these edits on a git branch and attribute commits to the author

## License

Fredit is distributed under the MIT-LICENSE.
