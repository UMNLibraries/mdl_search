FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install apt-transport-https -y
RUN apt-get update && apt-get install -y yarn
RUN mkdir /mdl_search
WORKDIR /mdl_search
ADD . /mdl_search
RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --jobs 20 --retry 5 --without production