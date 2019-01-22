class PermissionGroupItemsController < ApplicationController
  before_action :set_permission_group_item, only: [:show, :edit, :update, :destroy]

  # GET /permission_group_items
  # GET /permission_group_items.json
  def index
    @permission_group_items = PermissionGroupItem.all
  end

  # GET /permission_group_items/1
  # GET /permission_group_items/1.json
  def show
  end

  # GET /permission_group_items/new
  def new
    @permission_group_item = PermissionGroupItem.new
  end

  # GET /permission_group_items/1/edit
  def edit
  end

  # POST /permission_group_items
  # POST /permission_group_items.json
  def create
    @permission_group_item = PermissionGroupItem.new(permission_group_item_params)

    respond_to do |format|
      if @permission_group_item.save
        format.html { redirect_to @permission_group_item, notice: 'Permission group item was successfully created.' }
        format.json { render :show, status: :created, location: @permission_group_item }
      else
        format.html { render :new }
        format.json { render json: @permission_group_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permission_group_items/1
  # PATCH/PUT /permission_group_items/1.json
  def update
    respond_to do |format|
      if @permission_group_item.update(permission_group_item_params)
        format.html { redirect_to @permission_group_item, notice: 'Permission group item was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission_group_item }
      else
        format.html { render :edit }
        format.json { render json: @permission_group_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permission_group_items/1
  # DELETE /permission_group_items/1.json
  def destroy
    @permission_group_item.destroy
    respond_to do |format|
      format.html { redirect_to permission_group_items_url, notice: 'Permission group item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission_group_item
      @permission_group_item = PermissionGroupItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_group_item_params
      params.require(:permission_group_item).permit(:permission_id, :permission_group_id)
    end
end
