# ベースイメージの指定
FROM ruby:3.2.3-slim

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential default-libmysqlclient-dev git nodejs npm curl && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /myapp

# Node.jsとYarnのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# esbuildとtailwindcssのグローバルインストール
RUN yarn global add esbuild tailwindcss

# PATHの設定
ENV PATH="/usr/local/share/.config/yarn/global/node_modules/.bin:${PATH}"

# Gemfileのコピーと依存関係のインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードのコピー
COPY . .

# コンテナ起動時のコマンド
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]