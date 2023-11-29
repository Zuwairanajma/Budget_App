class EntityCategoriesController < ApplicationController
  before_action :set_group_category, only: %i[index new create edit update destroy]
  before_action :set_entity_category, only: %i[show edit update destroy]

  def index
    @entity_categories = @group_category.entity_categories.order(created_at: :desc)
  end

  def show; end

  def new
    @category = GroupCategory.includes(:author).find_by(id: params[:group_category_id]) || GroupCategory.first
    puts "Params: #{params.inspect}"
    puts "Category: #{@category.inspect}"
    @entity_category = EntityCategory.new
  end

  def create
    author = current_user
    @category = GroupCategory.includes(:author).find_by(id: params[:group_category_id])
    @entity_category = EntityCategory.new(entity_category_params)
    @entity_category.author = author
    if @entity_category.save
      category_item = CategoryItem.create(group_category: @category, entity_category: @entity_category)
      if category_item.persisted?

        flash[:notice] = 'Item creation successful'
        redirect_to group_category_path(@category)
      else
        flash[:alert] = 'Failed to associate with the category'
        redirect_to new_group_category_entity_category_path(@category)
      end
    else
      flash[:alert] = 'Item creation failed.'
      render :new
    end
  end

  def edit
    @group_category = GroupCategory.find(params[:group_category_id])
  end

  def update
    @group_category = GroupCategory.find(params[:group_category_id])

    if @entity_category.update(entity_category_params)
      redirect_to group_category_path(@group_category), notice: 'Entity category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entity_category = EntityCategory.find(params[:id])
    @entity_category.destroy
    redirect_to group_category_path(params[:group_category_id]), notice: 'Entity category was successfully destroyed.'
  end

  private

  def set_group_category
    @group_category = GroupCategory.find(params[:group_category_id])
  end

  def set_entity_category
    @entity_category = EntityCategory.find(params[:id])
  end

  def entity_category_params
    params.require(:entity_category).permit(:name, :amount)
  end
end
