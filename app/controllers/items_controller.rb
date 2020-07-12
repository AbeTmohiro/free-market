class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(index show)
  before_action :set_item, only: %i(show edit update destroy purchase_confirmation)
  before_action :user_is_not_seller, only: %i(edit update destroy)

  def index
    ladies_category = Category.find_by(name: "レディース")
    mens_category = Category.find_by(name: "メンズ")
    kids_category = Category.find_by(name: "ベビー・キッズ")

    ladies_items = Item.search_by_categories(ladies_category.subtree).new_items
    mens_items = Item.search_by_categories(mens_category.subtree).new_items
    kids_items = Item.search_by_categories(kids_category.subtree).new_items

    @new_items_arrays = [
       {category: ladies_category, items: ladies_items},
       {category: mens_category, items: mens_items},
       {category: kids_category, items: kids_items}
    ]
  end

  def new
    @item = Item.new
    @item.images.build
    render layout: 'no_menu'
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品に成功しました"
    else
      redirect_to new_item_path, alert: @item.errors.full_messages 
    end
  end

  def show
  end

  def edit
    @item.images.build
    render layout: 'no_menu' 
  end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: "出品に成功しました"
    else
      redirect_to edit_item_path(@item), alert: @item.errors.full_messages
    end
  end

  def purchase_confirmation
    render layout: 'no_menu' 
  end

 private

  def set_item
    @item = Item.find(params[:id])
  end
  
  def user_is_not_seller
    redirect_to root_path, alert: "あなたは出品者ではありません" unless @item.seller_id == current_user.id
  end

  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :detail,
      :condition,
      :delivery_fee_payer,
      :delivery_method,
      :delivery_days,
      :prefecture_id,
      :category_id,
      images_attributes: [:src, :id, :_destroy]
    ).merge(seller_id: current_user.id)
  end
end
