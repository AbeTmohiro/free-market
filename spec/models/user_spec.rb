require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nickname,e-mail,password,password_confirmation,first_name,first_name_reading,last_name,last_name_reading,birthdayが全て揃っていれば登録できる。" do
        expect(@user).to be_valid
      end
      it "nicknameは何文字でも登録できる" do
        @user.nickname = "i"
        expect(@user).to be_valid 
      end
      it "passwordが8文字以上、半角英数交りであれば登録できる" do
        @user.password = "aaaa0000"
        @user.password_confirmation = "aaaa0000"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      # nickname関連
      it "nicknameが空では登録できない" do
        @user.nickname = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Nicknameを入力してください")
      end
      # email関連
      it "emailが空では登録できない" do
        @user.email = "" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "emailに@が入っていないと登録できない" do
        @user.email = "aaaaaa" 
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      # password関連
      it "passwordが8文字以下では登録できない" do
        @user.password = "abc4567"
        @user.password_confirmation = "abc4567"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力して下さい。")
      end
      it "passwordに全角が入っていると登録できない" do
        @user.password = "ａbc4567"
        @user.password_confirmation = "ａbc4567"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字で入力して下さい。")
      end
      it "passwordとpassword_confirmationが一致していなければ登録できない" do
        @user.password = "aaaa0000"
        @user.password_confirmation = "aaaa0001"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      # birthday関連
      it "birth_dayが空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
      it "birth_dayが文字列では登録できない" do
        @user.birthday = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
    end
  end
end