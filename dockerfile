FROM ruby:2.5.1
  
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev vim

ENV INSTALL_PATH /bitestoque

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile $INTALL_PATH

ENV BUNDLE_PATH /gems

COPY . .

CMD bundle exec puma -C ./config/puma.rb
