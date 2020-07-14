require 'rails_helper'
describe User, type: :model do
  describe 'ユーザー新規登録' do
    it "nicknameが空では登録できない" do
      user = FactoryBot.build(:user) 
      user.nickname = "" 
      user.valid?
      expect(user.errors.full_messages).to include("Nicknameを入力してください")
    end
    it "emailが空では登録できない" do
      user = FactoryBot.build(:user)
      user.email = "" 
      user.valid?
      expect(user.errors.full_messages).to include("Eメールを入力してください")
    end
  end
end