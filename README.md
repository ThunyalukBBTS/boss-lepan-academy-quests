# Boss | Academy Quests

# Requirements

| Tools | Version |
| ----- | ------- |
| ruby  | 3.4.3   |
| rails | 8.0.2   |

# Setup project
- Install dependencies `bundle i`
- Create `.env` to collects credentials with template
    ```
    DATABASE_URL=postgres://xxx:yyy@localhost/zzz
    DB_USERNAME=xxx
    DB_PASSWORD=yyy
    DB_NAME=zzz
    ```
- Run local docker database `make db-up`
- Run migration `make migrate` or `rails db:migrate`
- Run rails dev server `make run` or `bin/dev`

# Commands
-   Run rails development server
    ```bash
    make run
    ```
-   Run migration
    ```bash
    make migrate
    ```
-   Run lint
    ```bash
    make lint
    ```
## Docker
-   Run app in container
    ```bash
    make app-up
    ```
-   Stop app in container
    ```bash 
    make app-down
    ```
- Start local docker database
    ```bash 
    make db-up
    ```
- Stop local docker database
    ```bash
    make db-down
    ```
## Testing
- Run all tests
    ```bash
    make test-all
    ```
- Run models and controllers testing
    ```bash
    make test
    ```
- Run E2E (UI) testing
    ```bash
    make e2e
    ```

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
        gem "rails-controller-testing"
        gem "rspec-rails"
        gem "capybara"
        gem "selenium-webdriver"
        gem "simplecov"
    end
    ```

-   Run rspec initial command `bundle exec rails generate rspec:install`
-   Edit config in `spec/rails_helper.rb` to use simplecov 
-   Try to run test using `bundle exec rspec`

## Main feature development

-   Create scaffold use template from [rails-generate.com](https://rails-generate.com/scaffold) then use command `bin/rails generate scaffold Quest name:string is_done:boolean`
-   Run migration `rails db:migrate` or `make migrate`
-   Change root path to quests#index in `config/routes.rb`
-   Custom elements in `_form.html.erb`, `_quest.html.erb`, `index.html.erb` in the folder `app/views/quests/` and edit layout of page in the `app/views/layouts/application.html.erb` file
-   Create Stimulus controller to control checkbox form submit using command `rails g stimulus checkbox` then create submit method that submit closest form

## Create brag document page

-   Generate controller

```bash
rails g controller Brag
```

-   Crete `app/views/brag/index.html.erb` file manually with your brag document information

```erb
<div class="your style">
  <div class="your style">
    <!-- back to home page button -->
    <%= link_to "Back", root_path %>
  </div>
</div>
```

-   Update `config/routes.rb` file to have path `/brag` that references to `brag` controller and method `index`

```rb
Rails.application.routes.draw do
  resources :quests
  get "up" => "rails/health#show", as: :rails_health_check
  get "/brag" => "brag#index", as: :brag
  root "quests#index"
end
```

## CI/CD

-   Update `.github/workflows/ci.yml` with my custom GitHub actions template (use rspec to run test instead of minitest)
    > [!WARNING]
    > Should run lint before push and run CI using `bundle exec rubocop -a`
-   Push code to GitHub repository then see the pipeline run in tab **Actions**

## Deployment

-   Try to deploy on local machine docker. Add the app service to services of `docker-compose.yml`
    ```yaml
    app:
        build: .
        container_name: academy-quest-boss-lepan-app
        command: bundle exec rails s
        environment:
            SECRET_KEY_BASE: ${SECRET_KEY_BASE}
            DATABASE_URL: ${DATABASE_URL_PRODUCTION}
        volumes:
            - .:/app
        ports:
            - 3000:3000
    ```
    Then update `.env` file with
    ```env
    DATABASE_URL=postgres://xxx:yyy@localhost/zzz
    DATABASE_URL_PRODUCTION=postgres://xxx:yyy@db/zzz
    # change ip from local host to db          ^^
    ```

### Create Render database

-   Go to [Render](https://render.com/) > Dashboard > login with your account > click `+ Add new` button > Postgres
-   Edit `Name`, `Database`, `User` with your custom name
-   For the best database latency should select `Region` to `Singapore (Southeast Asia)`
    > [!WARNING] >**Plan Options** should select `free`
-   Click `Create Database`
-   Then can use `External Database URL` in local machine to render database
-   Can use `Internal Database URL` in render container variables when you deployed app inside render

### Create Supabase database

-   Go to [Supabase](https://supabase.com) sign in
-   Create organization
-   **Copy the password** then save it
-   Click connect button > Session pooler > Copy url that start with `postgresql://` to `.env` then replace `[YOUR-PASSWORD]` with password
-   Then can use the supabase database with `DATABASE_URL`

### Deploy web service on Render

> [!NOTE]
> Your code should be in the GitHub repository and the repository should be public

-   Go to [Render](https://render.com/) > Dashboard > login with your account > click `+ Add new` button > `Web Service`
-   Source Code: Click `Public Git Repository` then copy url or the repository to repository url and naming the service
-   Select `Region` to `Singapore (Southeast Asia)`
    > [!WARNING] >**Plan Options** should select `free`
-   In the `Environment Variables` copy the variable name and value to render
    -   `WEB_CONCURRENCY` use default render value
    -   `RAILS_MASTER_KEY` the value is in the `config/master.key` file
    -   `SECRET_KEY_BASE` the value is in the `config/credentials.yml.enc` file
    -   `DATABASE_URL` from `Render` or `Supabase`
-   Click `Deploy Web Service` and wait until render deploy success then you can access your project with public url like `https://test.onrender.com/`
-   (Optional) For the best practice that we should deploy only the best code quality. we should setting render to re-deploy only the GitHub actions CI run passed only. Go to the render web service project > settings > `Auto-Deploy` change to `After CI Checks Pass`

### Autimate trigger deploy

-   Go to Render web service project > settings > Copy `Deploy Hook` url
-   Go to GitHub repository > Settings > Secrets and variables > Actions > In section `Repository secrets` > Click `New repository secret` > name `RENDER_DEPLOY_HOOK` and paste the `Deploy Hook` url in value
