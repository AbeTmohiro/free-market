FactoryBot.define do
  factory :item do
    before(:create) do |image|
      images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
    end
    name               {"バナナ"}
    price              {"9999"}
    detail             {"banana"}
    condition          {1}
    delivery_fee_payer {0}
    delivery_method    {0}
    delivery_days      {0}
    prefecture_id      {1}
    deal               {1}
    buyer_id           {1}
    seller_id          {1}
    category_id        {203}
  end
end