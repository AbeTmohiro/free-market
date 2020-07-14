require 'rails_helper'

describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品' do
    context '出品がうまくいくとき' do
      it "name,price,detail,condition,delivery_fee_payer,delivery_days,prefecture_id,dealが全て揃っていれば登録できる。" do
        expect(@item).to be_valid
      end
    end
  end
end
