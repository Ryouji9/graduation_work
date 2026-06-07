FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-mysql-client \
  default-libmysqlclient-dev \
  nodejs \
  postgresql-client \
  libpq-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile --gemfile
RUN bundle exec bootsnap precompile app/ lib/

EXPOSE 3000

CMD bash -c "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0"
