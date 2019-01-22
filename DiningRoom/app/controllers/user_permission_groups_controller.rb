class UserPermissionGroupsController < ApplicationController
  before_action :set_user_permission_group, only: [:show, :edit, :update, :destroy]

  # GET /user_permission_groups
  # GET /user_permission_groups.json
  def index
    @user_permission_groups = UserPermissionGroup.all
  end

  # GET /user_permission_groups/1
  # GET /user_permission_groups/1.json
  def show
  end

  # GET /user_permission_groups/new
  def new
    @user_permission_group = UserPermissionGroup.new
  end

  # GET /user_permission_groups/1/edit
  def edit
  end

  # POST /user_permission_groups
  # POST /user_permission_groups.json
  def create
    @user_permission_group = UserPermissionGroup.new(user_permission_group_params)

    respond_to do |format|
      if @user_permission_group.save
        format.html { redirect_to @user_permission_group, notice: 'User permission group was successfully created.' }
        format.json { render :show, status: :created, location: @user_permission_group }
      else
        format.html { render :new }
        format.json { render json: @user_permission_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_permission_groups/1
  # PATCH/PUT /user_permission_groups/1.json
  def update
    respond_to do |format|
      if @user_permission_group.update(user_permission_group_params)
        format.html { redirect_to @user_permission_group, notice: 'User permission group was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_permission_group }
      else
        format.html { render :edit }
        format.json { render json: @user_permission_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_permission_groups/1
  # DELETE /user_permission_groups/1.json
  def destroy
    @user_permission_group.destroy
    respond_to do |format|
      format.html { redirect_to user_permission_groups_url, notice: 'User permission group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_permission_group
      @user_permission_group = UserPermissionGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_permission_group_params
      params.require(:user_permission_group).permit(:user_id, :permission_group_id)
    end
end
