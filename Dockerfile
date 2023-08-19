FROM ruby:3.2.2
RUN mkdir /app
WORKDIR /app

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json

RUN bundle install
RUN npm install
RUN npx playwright install
RUN npx playwright install-deps
ADD . /app
