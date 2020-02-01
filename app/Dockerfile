FROM gcr.io/test-25245-264913/ruby@sha256:510b9962c734ec3c0886bcef0fc7d86b993435206181a54e46dd4e7dbe1af76b

WORKDIR /app/sports
COPY ./Gemfile* ./
RUN bundle install --deployment --without development test
COPY . /app/sports
RUN mkdir -p tmp/pids

EXPOSE 3000

CMD ["bin/setup"]
