class Api::CategoriesController < ApplicationController
  def index
    category = Category.find(params[:category_id])
    # childrenメソッド = 子カテゴリたちを取得する
    @categories = category.children
  end
end
