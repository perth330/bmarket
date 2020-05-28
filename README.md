# 概要

テックキャンプ最終課題にて作成したフリーマーケットのアプリケーションです<br>

## 開発期間と平均作業時間

・開発期間：約 3 週間
・1 日あたりの平均作業時間：約 10 時間

## 開発体制

・人数：5 名<br>
・アジャイル型開発（スクラム）<br>
・Trello によるタスク管理<br>

### 接続先情報

URL http://54.95.108.155/ <br>
ID/Pass<br>
・ID: bmarket<br>
・Pass: teamb<br>

**テスト用アカウント等**<br>
購入者用<br>
・メールアドレス: test1@gmail.com<br>
・パスワード: 1234567<br>  
購入用カード情報<br>
・番号：4242424242424242<br>
・期限：12/20<br>
・セキュリティコード：123<br><br>
出品者用<br>
・メールアドレス名: test2@gmail.com<br>
・パスワード: 1234567<br>

# 機能一覧

・ユーザー登録、住所登録(ウィザード形式)<br>
・住所登録追加（複数住所登録可）
・ログイン、ログアウト機能<br>
・商品出品、編集、削除機能<br>
・商品詳細コメント機能<br>
・商品カテゴリ機能<br>
・商品購入機能<br>
・商品検索機能<br>
・クレジットカード登録、削除機能(PayJP)<br>
・お気に入り機能<br>
・パンくず機能<br>

# 動作確認方法

- Chrome の最新版を利用してアクセスしてください。
- ただしデプロイ等で接続できないタイミングもございます。その際は少し時間をおいてから接続してください。
- 接続先およびログイン情報については、下記の通りです。
- 同時に複数の方がログインしている場合に、ログインできない可能性があります。

## 出品方法は以下の手順で確認できます

- テストアカウントでログイン → トップページから出品ボタン押下 → 商品情報入力 → 商品出品

## 購入方法は以下の手順で確認できます

- テストアカウントでログイン → トップページから商品検索 → 商品選択 → 商品購入

- 確認後、ログアウト処理をお願いします。

## その他の機能は以下手順で確認できます。

- ユーザーマイページにてお気に入り一覧確認（サイドバー お気に入り一覧）
- ユーザーマイページにて住所登録、削除（サイドバー お届け先住所登録）
- ユーザーマイページにてクレジットカード登録、削除（サイドバー 支払い方法）
- ユーザーマイページにて出品した商品の一覧確認（サイドバー 出品した商品 - 出品中・売却済）
  <br>
- 商品詳細ページにて出品者自身の商品の編集、削除
- 商品詳細ページにて商品のコメント
- 商品詳細ページにてお気に入り登録（ログイン中のみ）
  <br>
- 商品出品、編集時にカテゴリを選択
  <br>
- パンくず機能確認（ユーザーマイページ、商品詳細ページ、クレジットカード登録）

# 使用技術

## ◼︎ 言語

### バックエンド

Ruby 2.5.1

### フロントエンド

jquery 1.12.4

### マークアップ言語

HTML<br>
CSS<br>

### マークアップ記法

haml<br>
SCSS<br>

## ◼︎ フレームワーク

Ruby on Rails 5.2.4.2

## ◼︎ データベース

MySQL 5.6.47

## ◼︎ インフラ

AWS EC2<br>
AWS S3

## デプロイ

Capistrano による自動デプロイ

# bmarket DB 設計

## users テーブル

| Column           | Type   | Options                   |
| ---------------- | ------ | ------------------------- |
| family_name      | string | null: false               |
| first_name       | string | null: false               |
| family_name_kana | string | null: false               |
| first_name_kana  | string | null: false               |
| nickname         | string | null: false               |
| email            | string | null: false, unique: true |
| password         | string | null: false               |
| birthday         | date   | null: false               |

### Association

- has_many :comments
- has_many :credits
- has_many :purchases
- has_many :addresses
- has_many :products
- has_many :favorites, dependent: :destroy

## credits テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| number          | string     | null: false                    |
| effective_year  | integer    | null: false                    |
| effective_month | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| product | references | null: false, foreign_key: true |

### Association

- belongs_to :product
- belongs_to :user

## addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| family_name      | string     | null: false                    |
| first_name       | string     | null: false                    |
| family_name_kana | string     | null: false                    |
| first_name_kana  | string     | null: false                    |
| zipcode          | string     | null: false, limit:7           |
| prefecture       | string     | null: false                    |
| city             | string     | null: false                    |
| town             | string     | null: false                    |
| town_number      | string     | null: false                    |
| building         | string     |                                |
| tel              | string     |                                |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## purchases テーブル

| Column  | Type       | Options                                             |
| ------- | ---------- | --------------------------------------------------- |
| seller  | references | null: false, foreign_key: { to_table: :users }      |
| buyer   | references | null: false, foreign_key: true { to_table: :users } |
| product | references | null: false, foreign_key: true                      |
| address | references | null: false, foreign_key: true                      |

### Association

- belongs_to :product
- belongs_to :address

## products テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| introduction  | text       | null: false                    |
| condition     | string     | null: false                    |
| delivery_cost | string     | null: false                    |
| from          | string     | null: false                    |
| delivery_day  | string     | null: false                    |
| price         | integer    | null: false                    |
| size          | string     | null: false                    |
| status        | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| brand         | references | null: false, foreign_key: true |
| category      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :brand
- belongs_to :category
- has_many :comments, dependent: :destroy
- has_many :images, dependent: :destroy
- has_one :purchase, dependent: :destroy

## brands テーブル

| Column | Type   | Options                   |
| ------ | ------ | ------------------------- |
| name   | string | null: false, unique: true |

### Association

- has_many :products

## categories テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| ancestry | string | null: false |

### Association

- has_many :products
- has_ancestry

## images テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| image_url | text       | null: false                    |
| product   | references | null: false, foreign_key: true |

### Association

- belongs_to :product
