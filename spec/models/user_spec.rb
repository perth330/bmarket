require 'rails_helper'
describe User do
  describe '#create' do
    it "全てが存在すれば登録出来ること" do
      user = build(:user)
      expect(user).to be_valid
    end
    
    #空であれば登録できない[#1 ~ #9]
    #1
    it "「nicknameがない」場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    #2
    it "「emailがない」場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    #3
    it "「passwordがない」場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は7文字以上で入力してください")
    end
    #4
    it "「passwordが存在してもpassword_confirmationがない」場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    #5
    it "「お名前（全角)名字がない」場合は登録できないこと" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end
    #6
    it "「お名前（全角)名前がない」場合は登録できないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end
    #7
    it "「名字カナ（全角)がない」場合は登録できないこと" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end
    #8
    it "「名字カナ（全角)がない」場合は登録できないこと" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end
    #9
    it "「生年月日がない」場合は登録できないこと" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    #passwordフォーマット関係[#1 ~ #2]
    #1
    it "passwordが「7文字以上」であれば登録できること" do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end
    #2
    it "passwordが「6文字以下」であれば登録できないこと" do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end


    #お名前（全角)名字・名前フォーマット関係（登録できない）[#1 ~ #2]
    #1
    it "お名前（全角)名字が「ひらがな・カタカナ・漢字」でない場合は登録できないこと" do
      user = build(:user, family_name: "aaa")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end
    #2
    it "お名前（全角)名前が「ひらがな・カタカナ・漢字」でない場合は登録できないこと" do
      user = build(:user, first_name: "aaa")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    #お名前（全角)名字フォーマット関係（登録できる）[#1 ~ #3]
    #1
    it "お名前（全角)名字が「ひらがな」の場合は登録できる" do
      user = build(:user, family_name: "あ")
      user.valid?
      expect(user).to be_valid
    end
    #2
    it "お名前（全角)名字が「カタカナ」の場合は登録できる" do
      user = build(:user, family_name: "ア")
      user.valid?
      expect(user).to be_valid
    end
    #3
    it "お名前（全角)名字が「漢字」の場合は登録できる" do
      user = build(:user, family_name: "亜")
      user.valid?
      expect(user).to be_valid
    end

    #お名前（全角)名前フォーマット関係（登録できる）[#1 ~ #3]
    #1
    it "お名前（全角)名前が「ひらがな」の場合は登録できる" do
      user = build(:user, first_name: "い")
      user.valid?
      expect(user).to be_valid
    end
    #2
    it "お名前（全角)名前が「カタカナ」の場合は登録できる" do
      user = build(:user, first_name: "イ")
      user.valid?
      expect(user).to be_valid
    end
    #3
    it "お名前（全角)名字名前が「漢字」の場合は登録できる" do
      user = build(:user, first_name: "威")
      user.valid?
      expect(user).to be_valid
    end

    #名字カナ（全角)・名前カナ（全角)フォーマット関係[#1 ~ #2]
    #1
    it "名字カナ（全角)が「カタカナ」でない場合は登録できないこと" do
      user = build(:user, family_name_kana: "やまだ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end
    #2
    it "名前カナ（全角)が「カタカナ」でない場合は登録できないこと" do
      user = build(:user, first_name_kana: "たろう")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    #email フォーマット関係[#1 ~ #6]
    #1
    it "emailに@がない場合は登録できないこと" do
      user = build(:user, email: "yamadaemail.com")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    #2
    it "emailの「ユーザー名」が英数字、アンダースコア (_)、プラス (+)、ハイフン (-)、ドット (.) の
        いずれかを少なくとも1文字以上繰り返す文字がない場合は登録できないこと" do
      user = build(:user, email: "あ@email.com")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    #3
    it "emailの「独自ドメイン」で英小文字、数字、ハイフン、ドットを少なくとも
        １文字以上繰り返す文字がない場合は登録出来ないこと" do
      user = build(:user, email: "yamada@あ.com")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    #4
    it "emailの「トップレベルドメイン」が英小文字を少なくとも
        １文字以上繰り返す文字がない場合は登録出来ないこと" do
      user = build(:user, email: "yamada@email.あ")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    #5
    it "メールアドレスが「小文字化」されていること" do
      user = create(:user, email: "YAMADA@email.com")
      expect(user.email).to eq("yamada@email.com")
    end
    #6
    it "「重複したemailが存在」する場合登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end    
  end
end