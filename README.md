# Rails + SQLite3 Docker環境

Ruby on RailsとSQLite3が動作するDocker開発環境です。

## 必要なもの

- Docker
- Docker Compose

## セットアップ手順

### 1. Docker環境を構築

```bash
docker compose up --build -d
```

これでRailsとSQLite3が使える環境が構築されます。

### 2. Railsアプリケーションを作成

```bash
docker compose exec web rails new . --database=sqlite3 --skip-git --force
```

または、Makefileを使う場合：

```bash
make exec CMD="rails new . --database=sqlite3 --skip-git --force"
```

### 3. bundle installを実行

```bash
docker compose exec web bundle install
```

### 4. データベースを作成

```bash
docker compose exec web rails db:create
```

### 5. Railsサーバーを起動

```bash
docker compose exec web rails s -b '0.0.0.0'
```

### 6. ブラウザでアクセス

http://localhost:3000 にアクセスして、Railsアプリケーションが動作していることを確認します。

## よく使うコマンド

Makefileに便利なコマンドをまとめています。

```bash
make help           # コマンド一覧を表示
make up             # コンテナを起動
make down           # コンテナを停止
make logs           # ログを表示
make shell          # コンテナのシェルに入る
make console        # Railsコンソールを起動
make db-migrate     # マイグレーションを実行
make db-seed        # シードデータを投入
```

## ファイル構成

- `Dockerfile` - RubyとSQLite3の環境定義
- `docker-compose.yml` - コンテナ起動設定
- `Gemfile` - Rails gemの定義
- `Makefile` - 便利コマンド集
- `.dockerignore` - Docker用除外設定
