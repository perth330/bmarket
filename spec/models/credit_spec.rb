require "rails_helper"

describe Credit do
  describe "#create" do
    let(:user) { create(:user) }
    # 1
    it "user_idが空では登録できないこと" do
      card = build(:credit, user_id: "")
      card.valid?
      expect(card.errors[:user_id]).to include("を入力してください")
    end

    # 2. customer_idが空では登録できないこと
    it "customer_idが空では登録できないこと" do
      card = build(:credit, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

    # 3. card_idが空では登録できないこと
    it "card_idが空では登録できないこと" do
      card = build(:credit, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end
