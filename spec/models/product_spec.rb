require 'rails_helper'
describe Product do
  describe '#create' do
    let(:user){create(:user)}
    let(:category){create(:category)}
    let(:brand){create(:brand)}

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
      product = build(:product,user_id: nil)
      product.valid?
      expect(product.errors[:user]).to include("を入力してください")
    end

    it "brand_idがない場合は登録できないこと" do
      product = build(:product,brand_id: nil)
      product.valid?
      expect(product.errors[:brand]).to include("を入力してください")
    end

    it "category_idがない場合は登録できないこと" do
      product = build(:product,category_id:nil)
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
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

    it "priceが300以上のときは登録できること" do
      product = build(:product, price: "300")
      expect(product).to be_valid
    end

    it "priceが100万未満のときは登録できること" do
      product = build(:product, price: "999999")
      expect(product).to be_valid
    end

    it "sizeが未入力でも登録できること" do
      product = build(:product, size: "")
      expect(product).to be_valid
    end

    it "画像がないときは登録できないこと" do
      product = Product.new(name:"商品名",introduction:"説明", category_id:"1", size:"S", brand_id:"1", condition:"新品、未使用", delivery_cost:"着払い（購入者負担）", from:"北海道", delivery_day:"2〜3日で発送", price:"500",status:"出品中")
      product.valid?
      expect(product.errors[:images]).to include("を入力してください")
    end

    it "全項目入力ありで登録できること" do
      product = build(:product)
      expect(product).to be_valid
    end
  end


end