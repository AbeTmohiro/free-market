class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  belongs_to :category
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: :true


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  enum condition:{
    brand_new: 0,
    look_brand_new: 1,
    no_noticeable_scratches_or_stains: 2,
    with_a_little_scratches_and_dirt: 3,
    with_scratches_and_dirt: 4,
    bad_condition: 5
  }

  enum delivery_fee_payer:{
    postage_included: 0,
    freight_collect: 1
  }
    
  enum delivery_method:{
    undecided: 0,
    easy_mercari_flight: 1,
    yu_mail: 2,
    letter_pack: 3,
    regular_mail: 4,
    kuroneko_yamato: 5,
    yu_pack: 6,
    click_post: 7,
    yu_packet: 8
  }

  enum delivery_days:{
    ship_in_1to2days: 0,
    ship_in_2to3days: 1,
    ship_in_4to7days: 2
  }

  enum deal:{
    now_on_sale: 0,
    sold_out: 1
  }
end
    
#   enum condition:{
#     "新品、未使用": 0,
#     "未使用に近い": 1,
#     "目立った傷や汚れなし": 2,
#     "やや傷や汚れあり": 3,
#     "傷や汚れあり": 4,
#     "全体的に状態が悪い": 5
#   }

#   enum delivery_fee_payer:{
#     "送料込み（出品者負担）": 0,
#     "着払い（購入者負担）": 1
#   }
    
#   enum delivery_method:{
#     "未定": 0,
#     "らくらくメルカリ便": 1,
#     "ゆうメール": 2,
#     "レターパック": 3,
#     "普通郵便（定形、定形外）": 4,
#     "クロネコヤマト": 5,
#     "ゆうパック": 6,
#     "クリックポスト": 7,
#     "ゆうパケット": 8
#   }

#   enum delivery_days:{
#     "1〜2日で発送": 0,
#     "2〜3日で発送": 1,
#     "4〜7日で発送": 2
#   }

#   enum deal:{
#     "販売中": 0,
#     "売り切れ": 1
#   }
# end
