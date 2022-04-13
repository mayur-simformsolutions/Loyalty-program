# README
## System Dependencies
- Ruby 2.7.0
- Postresql 13.0

## Development Setup
1. Install Postgresql and create `simform` role with password
   - In `psql` console: `CREATE USER simform WITH CREATEDB;`
2. Git clone this repository
	 - git clone https://github.com/mayur-simformsolutions/Loyalty-program.git
3. `bundle install`
4. `rails db:create` 
5. `rails db:migrate`
6. `rails db:seed` to update the data base with sample data

## Running Dev Server
`rails server`

## Running Tests
`rspec` to run the test scripts to reduce the issues

## Services
- Sidekiq Cron `bundle exec sidekiq` for running scheduled jobs
	Can check the scheduled cron job here: http://localhost:3000/sidekiq/cron
  Reference https://github.com/ondrejbartas/sidekiq-cron

## Git flow
A standard flow would go like this:
1. Create a separate working branch (ideally indicate the intent in the name such as fix/feature/refactor/hotfix)
2. After developing merge the working branch to the develop branch which will trigger deployment to staging environment
3. Test on staging and get the requester sign-off
4. Once the code is production-ready create a new PR from the same working branch but set the base branch as main.
5. In case of any conflicts resolve them by merging main into the working branch and of course resolving the remaining conflicts if any
6. Request review
