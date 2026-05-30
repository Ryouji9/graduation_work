FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  default-mysql-client \
  default-libmysqlclient-dev \
  nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
