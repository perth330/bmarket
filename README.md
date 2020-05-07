# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


# bmarket DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|birthday|date|null: false|
### Association
- has_many :addresses
- has_many :comments
- has_many :credits
- has_many :dealings
- has_many :products

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|number|string|null: false|
|effective_year|integer|null: false|
|effective_month|integer|null: false|
### Association
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|product_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :product

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|zipcode|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|town|string|null: false|
|town_number|string|null: false|
|building|string||
|tel|string|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## dealingsテーブル
|Column|Type|Options|
|------|----|-------|
|seller_id|references|null: false, foreign_key: { to_table: :users } |
|buyer_id|references|null: false, foreign_key: true { to_table: :users }|
|product_id|references|null: false, foreign_key: true|
|address_id|references|null: false, optional: true|
### Association
- belongs_to :user
- belongs_to :product
- belongs_to :address

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|image_url|text|null: false|
|name|string|null: false|
|introduction|text|null: false|
|condition|string|null: false|
|delivery_cost|string|null: false|
|from|string|null: false|
|delivery_day|string|null: false|
|price|string|null: false|
|size|string|null: false|
|status|string|null: false|
|user_id|references|null: false, foreign_key: true|
|brand_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :address
- belongs_to :brand
- belongs_to :category
- has_many :comments
- has_many :images
- has_many :dealings
- has_many :products_tags
- has_many :tags,  through:  :products_tags

## tagsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :products_tags
- has_many :products,  through:  :products_tags

## products_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|null: false, foreign_key: true|
|tag_id|references|null: false, foreign_key: true|
### Association
- belongs_to :product
- belongs_to :tag

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :products

## categorysテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :products

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_url|text|null: false|
|product_id|references|null: false, foreign_key: true|
### Association
- has_many :products