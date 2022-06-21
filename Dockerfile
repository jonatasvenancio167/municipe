FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client imagemagick

ENV APP /home/app
WORKDIR $APP
COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock
RUN bundle install

RUN chown -R $USER:$USER .

CMD ["rails", "server", "-b", "0.0.0.0"]