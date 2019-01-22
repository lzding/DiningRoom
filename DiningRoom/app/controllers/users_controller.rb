class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :pick_order]



  # GET /users
  # GET /users.json
  def index
    if current_user.admin?
      @users = User.paginate(:page => params[:page])
    elsif current_user.manager?
      @users = User.without_admin.paginate(:page => params[:page])
    else
      @users = User.where(id: current_user.id).paginate(:page => params[:page])
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, user: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params.except(:id))
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.is_sys
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'Sysatem manager can\'t be destroyed.' }
        format.json { head :no_content }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def import
    if request.post?
      msg = Message.new
      begin
        file=params[:files][0]
        fd = FileData.new(data: file, oriName: file.original_filename, path: $tmp_file_path, pathName: "#{Time.now.strftime('%Y%m%d%H%M%S%L')}~#{file.original_filename}")
        fd.save
        msg = FileHandler::Excel::UserHandler.import(fd)
      rescue => e
        msg.content = e.message
      end
      render json: msg
    end
  end

  def permission_groups
    if request.post?
      pg_ids=[]
      params[:permission_groups_data].each do |p|
        if p.last[:status]=='true'
          pg_ids<<p.last[:id].to_i
        end
      end

      @user=User.find_by_id(params[:user_id])
      @user.manage_permission_groups(pg_ids)
      @permission_groups=@user.permission_group_details

      render :permission_groups
    else
      @user=User.find_by_id(params["format"])
      @permission_groups=@user.permission_group_details
    end
  end

  def pick_order
    puts '---------------------------------pick_order------------------------------------'
    puts @user
    order = OrderService.pick_order(@user)
    notice = "#{@user.nr} Order was successfully picked."
    notice = "It's past the latest booking time." if order.blank?

    respond_to do |format|
      format.html { redirect_to users_url, notice: notice }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:id,:nr,:email,:name,:password,:password_confirmation,:role_id)
  end
end
