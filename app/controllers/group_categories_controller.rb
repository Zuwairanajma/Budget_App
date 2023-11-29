class GroupCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group_category, only: %i[show edit update destroy]

  def index
    @group_categories = GroupCategory.where(author: current_user).order(created_at: :desc)
    puts @group_categories.inspect
  end

  def show
    @category = GroupCategory.find(params[:id])
    if @category.nil?
      flash[:alert] = 'Category not found'
      redirect_to root_path # or wherever you want to redirect in case of not found
      return
    end

    @entity_categories = @category.entity_categories.order(created_at: :desc)
  end

  def new
    @category = GroupCategory.new
  end

  def create
    category = GroupCategory.new(group_category_params)
    category.author = current_user
    category.true_id = current_user.id
    if category.save
      flash[:notice] = 'Category created successfully'
      redirect_to category
    else
      flash[:alert] = 'Category created failed'
      render new
    end
  end

  def edit
    @group_category = GroupCategory.find_by(id: params[:group_category_id])

    @entity_category = @group_category.entity_categories.find(params[:id])

    return if @group_category && @entity_category

    flash[:alert] = 'Group category or Entity category not found'
    redirect_to root_path
  end

  def update
    if @group_category.update(group_category_params)
      redirect_to @group_category, notice: 'Group category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entity_category = EntityCategory.find(params[:entity_category_id])
    @group_category = GroupCategory.find(params[:id])
    @group_category.destroy
    redirect_to group_categories_url, notice: 'Group category was successfully destroyed.'
  end

  private

  def set_group_category
    @group_category = GroupCategory.find(params[:id])
  end

  def group_category_params
    params.require(:group_category).permit(:name, :icon)
  end
end
