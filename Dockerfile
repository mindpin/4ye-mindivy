
FROM ruby:2.3.5

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - &&  apt-get install -y nodejs

WORKDIR /work
COPY . /work/
COPY ./config/mongoid.yml.docker /work/config/mongoid.yml

RUN bundle install
RUN npm install

EXPOSE 3000
CMD ["./entrypoint.sh"]