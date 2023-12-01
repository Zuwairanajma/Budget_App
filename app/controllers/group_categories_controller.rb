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

  def edit
    @group_category = current_user.group_categories.find(params[:id])
  end

  def update
    @group_category = current_user.group_categories.find(params[:id])

    if @group_category.update(group_category_params)
      redirect_to group_categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group_category = current_user.group_categories.find(params[:id])
    @group_category.destroy

    redirect_to group_categories_path, notice: 'Category was successfully destroyed.'
  end

  private

  def group_category_params
    params.require(:group_category).permit(:name, :icon)
  end
end
