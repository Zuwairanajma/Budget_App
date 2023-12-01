class GroupCategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group_categories = current_user.group_categories
  end

  def new
    @group_category = current_user.group_categories.build
  end

  def create
    @group_category = current_user.group_categories.build(group_category_params)

    if @group_category.save
      redirect_to group_categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  private

  def group_category_params
    params.require(:group_category).permit(:name, :icon)
  end
end
