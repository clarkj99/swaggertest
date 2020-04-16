# README

## SWAGGER Docs

- `gem "rspec-rails", "~> 4.0.0"` in development and test
- `gem "rswag"`
- Then run `rails g rswag:specs:install` at command line. Doc is created in spec/swagger_helper.rb.
- For the ui, run `rails g rswag:ui:install`.
- `rail g rswag:ap:install`.

- `rails g scaffold api/vi/users email name github_user registered_at:datetime`
