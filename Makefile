.PHONY: help build up down restart logs shell exec ps clean db-create db-migrate db-seed db-reset bundle install test

help: ## ヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Dockerイメージをビルド
	docker compose build

up: ## コンテナを起動
	docker compose up -d

down: ## コンテナを停止・削除
	docker compose down

restart: ## コンテナを再起動
	docker compose restart

logs: ## ログを表示
	docker compose logs -f web

shell: ## webコンテナのシェルに入る
	docker compose exec web bash

exec: ## webコンテナでコマンドを実行 (例: make exec CMD="rails c")
	docker compose exec web $(CMD)

ps: ## コンテナの状態を表示
	docker compose ps

clean: ## コンテナとボリュームを削除
	docker compose down -v

# データベース関連
db-create: ## データベースを作成
	docker compose exec web rails db:create

db-migrate: ## マイグレーションを実行
	docker compose exec web rails db:migrate

db-seed: ## シードデータを投入
	docker compose exec web rails db:seed

db-reset: ## データベースをリセット
	docker compose exec web rails db:reset

db-rollback: ## マイグレーションをロールバック
	docker compose exec web rails db:rollback

# Bundler関連
bundle: ## bundle installを実行
	docker compose exec web bundle install

bundle-update: ## bundle updateを実行
	docker compose exec web bundle update

# インストール・セットアップ
install: build up bundle db-create db-migrate ## 初回セットアップ

# テスト
test: ## テストを実行
	docker compose exec web rails test

# その他
console: ## Railsコンソールを起動
	docker compose exec web rails console

routes: ## ルート一覧を表示
	docker compose exec web rails routes

server: ## Railsサーバーを起動（PIDファイルをクリーンしてから）
	rm -f tmp/pids/server.pid
	docker compose exec web rails s -b '0.0.0.0'

clean-pid: ## PIDファイルをクリーン
	rm -f tmp/pids/server.pid

assets-precompile: ## アセットをプリコンパイル
	docker compose exec web rails assets:precompile
