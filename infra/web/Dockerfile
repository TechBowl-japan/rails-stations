FROM ruby:2.7.3
RUN apt-get update -qq
RUN apt-get install -y nodejs npm && npm install n -g && n lts
RUN npm install -g yarn
RUN mkdir /app
WORKDIR /app

# このDockerfileでgemのインストールやyarnによるパッケージのインストールをしていないのは、
# ログインなどの処理を挟む必要があるため。
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
