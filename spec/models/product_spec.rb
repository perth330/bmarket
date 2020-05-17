require 'rails_helper'
describe Product do
  describe '#create' do
    let(:user){create(:user)}
    let(:brand){create(:brand)}
    let(:category){create(:category)}
    it "nameがない場合は登録できないこと" do

      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "introductionがない場合は登録できないこと" do

      product = build(:product, introduction: "")
      product.valid?
      expect(product.errors[:introduction]).to include("を入力してください")
    end

    it "conditionがない場合は登録できないこと" do

      product = build(:product, condition: "")
      product.valid?
      expect(product.errors[:condition]).to include("を入力してください")
    end

    it "delivery_costがない場合は登録できないこと" do

      product = build(:product, delivery_cost: "")
      product.valid?
      expect(product.errors[:delivery_cost]).to include("を入力してください")
    end

    it "fromがない場合は登録できないこと" do

      product = build(:product, from: "")
      product.valid?
      expect(product.errors[:from]).to include("を入力してください")
    end

    it "delivery_dayがない場合は登録できないこと" do

      product = build(:product, delivery_day: "")
      product.valid?
      expect(product.errors[:delivery_day]).to include("を入力してください")
    end

    it "priceがない場合は登録できないこと" do

      product = build(:product, price: "")
      product.valid?
      expect(product.errors[:price]).to include("は数値で入力してください")
    end

    it "statusがない場合は登録できないこと" do

      product = build(:product, status: "")
      product.valid?
      expect(product.errors[:status]).to include("を入力してください")
    end

    it "user_idがない場合は登録できないこと" do

      product = build(:product, user_id: "")
      product.valid?
      expect(product.errors[:user_id]).to include("を入力してください")
    end

    it "brand_idがない場合は登録できないこと" do

      product = build(:product, brand_id: "")
      product.valid?
      expect(product.errors[:brand_id]).to include("を入力してください")
    end

    it "category_idがない場合は登録できないこと" do

      product = build(:product, category_id: "")
      product.valid?
      expect(product.errors[:category_id]).to include("を入力してください")
    end

    it "priceが300未満のときは登録できないこと" do

      product = build(:product, price: "299")
      product.valid?
      expect(product.errors[:price]).to include("は299より大きい値にしてください")
    end

    it "priceが100万以上のときは登録できないこと" do

      product = build(:product, price: "1000000")
      product.valid?
      expect(product.errors[:price]).to include("は1000000より小さい値にしてください")
    end

    it "画像がないときは登録できないこと" do

      product = build(:product_without_image)
      product.valid?
      expect(product.errors[:images]).to include("を入力してください")
    end

  end


end