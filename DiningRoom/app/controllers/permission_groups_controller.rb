class PermissionGroupsController < ApplicationController
  before_action :set_permission_group, only: [:show, :edit, :update, :destroy]

  # GET /permission_groups
  # GET /permission_groups.json
  def index
    @permission_groups = PermissionGroup.all.paginate(:page => params[:page])
  end

  # GET /permission_groups/1
  # GET /permission_groups/1.json
  def show
  end

  # GET /permission_groups/new
  def new
    @permission_group = PermissionGroup.new
  end

  # GET /permission_groups/1/edit
  def edit
  end

  # POST /permission_groups
  # POST /permission_groups.json
  def create
    @permission_group = PermissionGroup.new(permission_group_params)

    respond_to do |format|
      if @permission_group.save
        format.html { redirect_to @permission_group, notice: 'Permission group was successfully created.' }
        format.json { render :show, status: :created, location: @permission_group }
      else
        format.html { render :new }
        format.json { render json: @permission_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permission_groups/1
  # PATCH/PUT /permission_groups/1.json
  def update
    respond_to do |format|
      if @permission_group.update(permission_group_params)
        format.html { redirect_to @permission_group, notice: 'Permission group was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission_group }
      else
        format.html { render :edit }
        format.json { render json: @permission_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permission_groups/1
  # DELETE /permission_groups/1.json
  def destroy
    @permission_group.destroy
    respond_to do |format|
      format.html { redirect_to permission_groups_url, notice: 'Permission group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def permission_details
    @permissions=[]
    if permission_group=PermissionGroup.find_by_id(params[:permission_groups_id])
      permission_group.permissions.each do |p|
        @permissions<<p.description
      end
    end

    render :json => @permissions
  end

  def add_permissions
    if request.post?
      p_ids=[]
      params[:permission_data].each do |p|
        if p.last[:status]=='true'
          p_ids<<p.last[:id].to_i
        end
      end

      @permission_group=PermissionGroup.find_by_id(params[:permission_group_id])
      @permission_group.manage_permissions(p_ids)
      @permissions=@permission_group.permission_details

      render :add_permissions
    else
      @permission_group=PermissionGroup.find_by_id(params["format"])
      @permissions=@permission_group.permission_details
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission_group
      @permission_group = PermissionGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permission_group_params
      params.require(:permission_group).permit(:name, :description)
    end
end
