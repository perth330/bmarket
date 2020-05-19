require 'rails_helper'

describe Address do
  describe '#create' do
    it "全て入力で登録出来る" do
      address = build(:address,building: "タワー", tel: "09087654321")
      expect(address).to be_valid
    end

    it "マンション名または連絡先がなくても登録出来る" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "姓がないと登録出来ない" do
      address = build(:address,family_name: "")
      address.valid?
      expect(address.errors[:family_name]).to include("を入力してください")
    end

    it "名がないと登録出来ない" do
      address = build(:address, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end

    it "姓（カナ）がないと登録出来ない" do
      address = build(:address, family_name_kana: "")
      address.valid?
      expect(address.errors[:family_name_kana]).to include("を入力してください")
    end

    it "名（カナ）がないと登録出来ない" do
      address = build(:address, first_name_kana: "")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end

    it "郵便番号がないと登録出来ない" do
      address = build(:address, zipcode: "")
      address.valid?
      expect(address.errors[:zipcode]).to include("を入力してください")
    end

    it "都道府県がないと登録出来ない" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("を入力してください")
    end

    it "市がないと登録出来ない" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "町村区郡がないと登録出来ない" do
      address = build(:address, town: "")
      address.valid?
      expect(address.errors[:town]).to include("を入力してください")
    end

    it "番地がないと登録出来ない" do
      address = build(:address, town_number: "")
      address.valid?
      expect(address.errors[:town_number]).to include("を入力してください")
    end
  end
end