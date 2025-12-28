FROM ruby:3.2

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libsqlite3-dev \
    nodejs \
    npm && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# Gemfileをコピー（存在する場合）
COPY Gemfile* ./

# Bundlerのインストールとgem依存関係のインストール
RUN gem install bundler && \
    if [ -f Gemfile ]; then bundle install; fi

# アプリケーションコードをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

# Railsサーバーの起動
CMD ["rails", "server", "-b", "0.0.0.0"]
