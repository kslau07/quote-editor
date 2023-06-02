# Rails Turbo Tutorial

Tutorial is here:
https://www.hotrails.dev/turbo-rails/crud-controller-ruby-on-rails

@quote vs quote
	edit.html.erb -> uses @quote
		~ is passed @quote from the controller
	_quote.html.erb -> uses quote 
		~ is passed a m/i from index

What's going on turbo frames here?
First, note that we use `"quote_#{quote.id}"` to uniquely name the frame.
Part of tut found here:
	find this on page (~50%): "We need a Turbo Frame of the same id around the form of the Quotes#edit page:"
	https://www.hotrails.dev/turbo-rails/turbo-frames-and-turbo-streams
_quote passes in the correct quote m/i to edit.html.erb
The thing that we thought was a wrapper is the actual frame that is switched out.
Both sides have a  `"quote_#{quote.id}"` frame, just as it was demonstrated before.


<%= link_to quote.name, quote_path(quote)>						# path helper for model instance (record)

Added before_action -> { sleep 3 } to ApplicationController to check out the progress bar.

Use `bin/setup` as it installs gems, installs js dependencies, and creates, migrates, and seeds the db.

Use `bin/dev` instead of `rails server` as it updates scss changes (and js too).

Chrome Devtools:Network (data: { turbo: true/false })
* GET "fetch" is an AJAX request
	- We see this with data: { turbo: true }
	- Fewer GET requests in total
* GET "document" is a normal HTTP GET
	- We see this with data: { turbo: false }
	- Lots of GETs seen

Sass CSS: Do not forget to include sass in Gemfile. Run `bundle install`

After completion of tutorial, go back and review css methodology, mixin, config and components.

We add a .scss file
	// app/assets/stylesheets/mixins/_media.scss
The "outer" part is the css for mobile, it is empty as all of the css applies to mobile.
The "inner" part (tabletAndUp) ... what does it do?

Author writes CSS using the BEM (Block Element Modifier) methodology.

**BEM CSS**
1. B - block - each component, block, should have a unique name.
2. E - element - each block can have many elements
3. M - modifier - each block may have modifiers

Components are independent pieces of the webpage, eg a button.
A layout is concerned about margins, centering, positioning components.

About margins and components: since components are only concerned about themselves, they should not have any outer margin. 
However, since this is a simple app, the author has chosen to give components margins.

We can reuse the data from the fixtures to create our development data.
We won't have to do the work twice (once for each file)
Test data and dev data will be kept in sync.
The code to use fixture data for seeding is in:
	seeds.rb
The command to seed the db is:
`bin/rails db:seed`

What are fixtures?
	Fixtures are data that you can feed into your unit testing. They are automatically created whenever rails generates the corresponding tests for your controllers and models. They are only used for your tests and cannot actually be accessed when running the application.

Remove chrome popup
	# test/application_system_test_case.rb
		# Change :chrome with :headless_chrome
		driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

Error: Button with "Create quote" became "Create Quote" because simple_form capitalized.
Solution: Replaced my version of simple_form.en.yml with the one from the website. Ours had syntax errors somewhere.

Included something called "simple_form"
Install with this
	bin/rails generate simple_form:install
Our form is located at
	app/views/quotes/_form.html.erb
The simple_form basically will populate class fields automatically for our forms, among other things. See page for more details:
	https://www.hotrails.dev/turbo-rails/crud-controller-ruby-on-rails
One key thing is to look at our default wrapper setting in "simple_form.rb".
When we use f.input :name without specifying a wrapper, simple_form wraps it with the default.
There is another file to set things:
	config/locales/simple_form.en.yml



We may choose to use the form and error partials from here in other projects.

Recall that %i[index show update] is an array of symbols.

**bin/rails test:system** Run tests (Capybara?)

**bin/setup** -> install dependencies and create the database (???)
Read more here: https://thoughtbot.com/blog/bin-setup
* The goal of the bin/setup script is quick, reliable, consistent setup. It is placed in the `bin` directory to match "Rails conventions about executables."
* I see that bin/setup runs:
	1. bundle install
	2. git remote add staging git@heroku.com:app-staging.git
	3. git remote add production git@heroku.com:app-production.git
	4. bundle exec rake db:setup 																									# rails db:create?
	5. Set up configurable env variables for Foreman
	6. Set up DNS

**bin/dev** is to run cssbundling and jsbundling

**Foreman** -> Foreman is a tool for managing Procfile-based applications.

**Procfile** -> The starting point for any app running on Heroku and other cloud platforms. At it simplest, the Procfile is where you declare the one or more processes to be run for your app to function.

```
#Procfile.dev

# The 3 things that bin/dev does:

web: bin/rails server -p 3000							# Launches the rails server on port 3000

# These are in charge of precompiling our CSS and JavaScript code before handing them to the asset pipeline. 

js: yarn build --watch
css: yarn build:css --watch

# The --watch option is here to ensure the CSS and JavaScript code is compiled every time we save a CSS/Sass or JavaScript file.
```