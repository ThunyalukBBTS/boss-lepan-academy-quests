# Boss | Academy Quests

# Requirements

| Tools | Version |
| ----- | ------- |
| ruby  | 3.4.3   |
| rails | 8.0.2   |

# Steps

-   Initialize project with command `rails new boss-lepan-academy-quests`
-   Setup local machine database by create `docker-compose.yml` file with template
    ```yaml
    services:
        db:
            image: postgres:17.4-alpine
            restart: always
            environment:
                POSTGRES_USER: ${DB_USERNAME}
                POSTGRES_PASSWORD: ${DB_PASSWORD}
                POSTGRES_DB: ${DB_NAME}
            ports:
                - 5432:5432
            volumes:
                - academy-quests-data:/var/lib/postgresql/data
    volumes:
        academy-quests-data:
    ```
-   Create `.env` to collects credentials with template
    ```
    DATABASE_URL=postgres://xxx:yyy@localhost/zzz
    DB_USERNAME=xxx
    DB_PASSWORD=yyy
    DB_NAME=zzz
    ```
-   Edit rails database connection in `database.yml` with template

    ```yml
    default: &default
        adapter: postgresql
        encoding: unicode
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        url: <%= ENV.fetch("DATABASE_URL") { "postgres://localhost/<database_name>" } %>

    development:
        <<: *default
        database: <database_name>_development

    test:
        <<: *default
        database: <database_name>_test

    production:
        primary: &primary_production
            <<: *default
            url: <%= ENV.fetch("DATABASE_URL") { "postgres://localhost/<database_name>" } %>
        cache:
            <<: *primary_production
        queue:
            <<: *primary_production
        cable:
            <<: *primary_production
    ```

-   Start up local postgresql database on docker using `docker compose up -d db`
-   Run rails dev server `bin/dev`

## Test setup

-   Edit `Gemfile` to have rspec test tool

    ```gemfile
    group :test do
        gem "rspec-rails"
        gem "capybara"
        gem "selenium-webdriver"
    end
    ```

-   Run rspec initial command `bundle exec rails generate rspec:install`
-   Edit `spec/rails_helper.rb`
-   Try to run test using `bundle exec rspec`
## Main feature development
- Create scaffold use template from [rails-generate.com](https://rails-generate.com/scaffold) then use command `bin/rails generate scaffold Quest name:string is_done:boolean`
- Run migration `rails db:migrate` or `make migrate`
- Change root path to quests#index in `config/routes.rb`
- Custom elements in `_form.html.erb`, `_quest.html.erb`, `index.html.erb` in the folder `app/views/quests/` and edit layout of page in the `app/views/layouts/application.html.erb` file
- Create Stimulus controller to control checkbox form submit using command `rails g stimulus checkbox` then create submit method that submit closest form
- 