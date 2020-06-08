class Item < ApplicationRecord
  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  validates :images, length: { minimum: 1, maximum: 5, message: "の数が不正です" }

  def self.search_by_categories(categories)
    return Item.where(category: categories).includes(:images)
  end
  
  private

  belongs_to :category
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: :true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, update_only: true
  


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
