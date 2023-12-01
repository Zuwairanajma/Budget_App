class EntityCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group_category, only: %i[index new create edit update destroy]

  def index
    @group_category = GroupCategory.find(params[:group_category_id])
    @entity_categories = @group_category.entity_categories
  end

  def new
    @entity_category = @group_category.entity_categories.build
    @group_categories = current_user.group_categories
  end

  def create
    @entity_category = current_user.entity_categories.build(entity_category_params)
    @group_categories = current_user.group_categories

    if @entity_category.save
      redirect_to group_category_entity_categories_path(@group_category),
                  notice: 'Entity category was successfully created.'
    else
      render :new
    end
  end

  # def edit
  #   @entity_category = current_user.entity_categories.find(params[:id])
  # end
  def edit
    @group_category = GroupCategory.find(params[:group_category_id])
    @entity_category = current_user.entity_categories.find(params[:id])
  end

  def update
    #   @entity_category = current_user.entity_categories.find(params[:id])
    @entity_category = @group_category.entity_categories.find(params[:id])

    if @entity_category.update(entity_category_params)
      redirect_to group_category_entity_categories_path(@group_category),
                  notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entity_category = current_user.entity_categories.find(params[:id])
    @entity_category.destroy

    redirect_to entity_categories_path, notice: 'Transaction was successfully destroyed.'
  end

  private

  def entity_category_params
    params.require(:entity_category).permit(:name, :amount, :group_category_id)
  end

  def load_group_categories
    @group_categories = current_user.group_categories
  end

  def set_group_category
    @group_category = GroupCategory.find_by(id: params[:group_category_id])
    redirect_to root_path, alert: 'Invalid Group Category' unless @group_category
    # @group_categories = current_user.group_categories
  end
end
