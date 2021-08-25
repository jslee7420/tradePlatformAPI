FROM ruby:3.0.2

WORKDIR /

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . /

RUN rails db:setup

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]