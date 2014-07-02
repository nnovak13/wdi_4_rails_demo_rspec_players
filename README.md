# RSpec Player Tracker Demo

We'll use several new gems in this demo. Reading their documentation may be helpful:

* [rspec-rails](https://github.com/rspec/rspec-rails) integrates RSpec into Rails
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) helps us test associations and validations
* [factory_girl](https://github.com/thoughtbot/factory_girl) lets us quickly create test data, along with [Faker](https://github.com/stympy/faker)
* [Capybara](https://github.com/jnicklas/capybara) gives us a fake web browser to manipulate from RSpec
* [Poltergeist](https://github.com/teampoltergeist/poltergeist) enhances that fake browser with JavaScript support
* [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) helps RSpec reset the test database properly when using Poltergeist

## Setup Process

For reference, listed below is the process for setting up our "standard" Rails testing environment. This process is forward-looking &ndash; Poltergeist and Database Cleaner are not actually needed for this specific demo, but they will come in handy once you start developing Rails apps that use JavaScript.

1. Add the gems listed in the Gemfile for this project
2. Run `bundle`
3. Run `rails g rspec:install`
4. Remove `--warnings` line from `.rspec`
5. Remove `=begin` and `=end` lines from `spec/spec_helper.rb`
6. In `spec/rails_helper.rb`:
  * Add `require 'capybara/rails'` under the other requires
  * Add `require 'capybara/poltergeist'` under that
  * Add `Capybara.javascript_driver = :poltergeist` under that
  * Comment out the line `config.fixture_path = ...`
  * Comment out the line `config.use_transactional_fixtures = true`
  * Under those lines, add `config.include FactoryGirl::Syntax::Methods`
7. Create a `spec/support` directory
8. Create the file `spec/support/database_cleaner.rb` with this content:

```
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
```

### User Sign-In Helper

In apps that require user sign-in for some actions, constantly repeating the link-clicking and form-filling steps to actually sign in can add a lot of noise to your tests. To avoid this, we can write a sign-in helper.

In `spec/rails_helper.rb`, under the `config.include FactoryGirl...` line, add this line:

```
config.include SessionHelpers
```

Then create the file `spec/support/session_helpers.rb` with this content:

```
module SessionHelpers
  def sign_in_as(user)
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
```

You might need to change the link/button/field names depending on the wording your app uses. Now you can call `sign_in_as` anywhere in a feature spec, passing it a user object (perhaps created with `create(:user)`), and it will perform the steps to sign in as that user.
