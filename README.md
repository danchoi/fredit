# fredit: front-end edit

fredit is a very simple, no-frills Rails 3 Engine that lets you edit your
Rails application's view templates, css stylesheets, and javascript
files (a.k.a front-end files) through the browser.

fredit injects an edit link into every view template. These edit links
are visible wherever the template is rendered, whether it is a layout,
a page, or a partial. 

<img style="width:300px" src="https://github.com/danchoi/fredit/raw/master/screens/links.png"/>

By clicking on these links, you call up a edit page that will let you
directly edit the source. An update button lets you save these changes
and alter the underlying source files.

<img style="width:300px" src="https://github.com/danchoi/fredit/raw/master/screens/fredit.png"/>

In addition to view templates, stylesheets and javascript files are
accessible through a file selection drop down at the top of the fredit
edit page. 

You can also create and delete front-end files on the fredit edit page.

**NOTE: Currently only the ERB Rails template handler is supported.**
You are welcome to fork and add support for Haml and other template
handlers. 


## Why fredit? Because it helps me get helped

On a current Rails project, I needed to delegate responsibility for
improving the copy, the styling, and the user interface to another
person. Let's call this person "Chad." Chad:

* is not a Ruby or Rails programmer
* knows HTML and CSS
* can make perfect sense of ERB, Rails partials, and basic Ruby
  constructs found in ERB after a few minutes of explanation 
* can use a web browser interface to edit files

One option here is to set up a full Rails development environment on
Chad's computer. But this option sucks for several reasons. Chad is not
very familiar with the command line, git, RVM, Ruby, rake, bundler, or
you name it. To get Chad started, I would have to install a thousand and
one dependencies on Chad's computer. I would have to tutor Chad on
dozens of rails, bundler, gem, rake, and git incantations.  All this
just so Chad can tweak the frackin view templates and stylesheets. This
is madness. 

Another option is to integrate a CMS into your Rails app. But in
addition to adding a mass of dependencies and code bloat, this approach
is too restrictive when you want to give your collaborator as much
control over the front-end as he or she can handle.

**fredit helps you empower capable non-Rails programmers to help you on
the front-end of a Rails app, with less overhead.** 

Just run a fredit-enabled instance of your Rails app on a server that he
or she can access through a web browser.  This fredit-able instance can
have its own Rails environment, database, and git branch. You probably
put a copy of your app on a staging server anyway, so you can use that
instance for fredit-ing.

## The best Ruby templating system is other people

It's becoming less and less sustainable to have Rails programmers serve
as gatekeepers and bottlenecks through which all markup and source code
must pass.  Part of the answer must be finding better ways to allow
people with a even just little bit of Ruby, HTML, JavaScript, and CSS
knowledge to take some of the workload off our broad but still finite
programming shoulders.  

Instead of looking for the next Haml or Slim or Sass, which shaves off
yet another 0.5 percent of superfluous typing from your template and css
typing sessions, isn't it better to make it easier for OTHER PEOPLE,
EVEN NON-RAILS EXPERTS, to write and maintain the view layer for you?
Who knows, they might even find it fun and educational.

More compact DSLs are not the only way to increase programmer happiness
and productivity. Another way is to achieve a more productive division
of labor with those who aren't full-stack web dev ninjas but who are
available and willing to help.  Think [comparative
advantage][comparative] from your college economics class. We need to
apply this idea more to software development.

[comparative]:http://www.econlib.org/library/Topics/Details/comparativeadvantage.html


## Install and setup

fredit requires Rails 3.

fredit works best as a gem you include in a specific Rails
environment. Put something like this in the `Gemfile` of your Rails app:

    source 'http://rubygems.org'

    [lines omitted]

    group :staging do
      gem 'fredit'
    end

and then run `RAILS_ENV=staging bundle install`, adjusting the
`RAILS_ENV` to your target environment.

To run your Rails app with fredit, just start it in the Rails
environment corresponding to the Gemfile group you put fredit in. When
you hit the app in the browser, you should see the injected view
template links and be able to click through them to fredit's source code
editor.


## Use fredit with git 

fredit assumes that the Rails instance it is running on is a git
repository. **It also assumes that you have set the current branch of
this git repository to the one you want your collaborator's changes
committed to.**

When your collaborator makes changes, fredit will commit those changes
on the current git branch of this clone of the git repository. There is
a form field in the fredit editor for the collaborator to enter git
author information and a git log message. These bits of information
will be added as metadata to the git commit.

When you're ready to review and merge the changes your collaborator made
via fredit, it's all just a matter of working with git commits and
branches. You can set up client-side git hooks on the fredit-enabled
clone to notify you when your collaborator has made changes, to
automatically push those changes to the appropriate branch in the
upstream repository, run a CI build server, etc.


## Security

Currently, fredit has only rudimentary security features. fredit will
not allow any user to use the fredit web interface to edit a file above
or outside the Rails application root directory of that Rails instance.
But this still leaves things like database.yml configurations accessible
to the fredit editor. Anyone with access to the fredit editing interface
will have the power to run arbitrary SQL on your environment's database.

So please take additional precautions to make sure that your
fredit-enabled Rails instance can't be accessed by hostile strangers.
At a minimum, use Basic Authentication or the like to restrict access to
this entire Rails instance. 

It's probably not a good idea to run a fredit-enabled Rails app on a
server with important stuff on it. Use a scratch staging server.


## Contribute

Feel free to fork and take this simple idea wherever you want to. The
current version of this project is really just a quick and dirty
implementation that I needed pronto. Pull requests are very welcome.



## License

Fredit is distributed under the MIT-LICENSE.
