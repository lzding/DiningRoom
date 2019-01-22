require 'active_support/core_ext/string/date'
class AttendanceNotesController < ApplicationController
  before_action :set_attendance_note, only: [:show, :edit, :update, :destroy, :clock_in, :clock_out, :clock_append]

  # GET /attendance_notes
  # GET /attendance_notes.json
  def index
    if current_user.admin? || current_user.manager?
      @attendance_notes = AttendanceNote.paginate(:page => params[:page]).order(work_date: :DESC, status: :DESC)
    else
      @attendance_notes = AttendanceNote.where(user_id: current_user.id).paginate(:page => params[:page]).order(work_date: :DESC, status: :DESC)
    end
  end

  # GET /attendance_notes/1
  # GET /attendance_notes/1.json
  def show
  end

  # GET /attendance_notes/new
  def new
    @attendance_note = AttendanceNote.new
  end

  # GET /attendance_notes/1/edit
  def edit
  end

  # POST /attendance_notes
  # POST /attendance_notes.json
  def create
    @attendance_note = AttendanceNote.new(attendance_note_params)

    respond_to do |format|
      if @attendance_note.save
        format.html { redirect_to @attendance_note, notice: 'Attendance note was successfully created.' }
        format.json { render :show, status: :created, location: @attendance_note }
      else
        format.html { render :new }
        format.json { render json: @attendance_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendance_notes/1
  # PATCH/PUT /attendance_notes/1.json
  def update
    respond_to do |format|
      if @attendance_note.update(attendance_note_params)
        format.html { redirect_to @attendance_note, notice: 'Attendance note was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance_note }
      else
        format.html { render :edit }
        format.json { render json: @attendance_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendance_notes/1
  # DELETE /attendance_notes/1.json
  def destroy
    @attendance_note.destroy
    respond_to do |format|
      format.html { redirect_to attendance_notes_url, notice: 'Attendance note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def clock_in
    if @attendance_note.work_date.localtime.day==Time.now.localtime.day
      @attendance_note.update({on_duty_time: Time.now, status: AttendanceNoteState::ON_DUTY})
      notice = 'Clock In successfully.'
    else
      notice = 'Clock In Date is not right, Please check it.'
    end

    respond_to do |format|
      format.html { redirect_to attendance_notes_url, notice: notice }
      format.json { head :no_content }
    end
  end

  def clock_out
    if @attendance_note.status==AttendanceNoteState::ON_DUTY && @attendance_note.work_date.localtime.day==Time.now.localtime.day
      @attendance_note.update({off_duty_time: Time.now, status: AttendanceNoteState::ON_DUTY})
      notice = 'Clock Out successfully.'
    else
      notice = 'Clock Out Date is not right, Please check it Or Press Fill Clock Btn.'
    end

    respond_to do |format|
      format.html { redirect_to attendance_notes_url, notice: notice }
      format.json { head :no_content }
    end
  end

  def clock_append
    puts "----------------------------------clock_append--------------------------------------------"
    if @attendance_note
      if params[:fill_clock_time].blank? || !params[:fill_clock_time].is_date? || params[:fill_clock_type].blank? || params[:remark].blank?
        render :json => {result: false, content: '补打卡时间、类型和备注不能为空'}
      else
        puts DateTime.parse(params[:fill_clock_time])
        puts Time.parse(params[:fill_clock_time])
        puts DateTime.parse(params[:fill_clock_time]).localtime
        puts Time.parse(params[:fill_clock_time]).localtime
        if (@attendance_note.work_date.localtime.day..@attendance_note.work_date.localtime.day+1).include? DateTime.parse(params[:fill_clock_time]).day
          @attendance_note.update({
                                      fill_clock_time: Time.parse(params[:fill_clock_time]),
                                      fill_clock_type: params[:fill_clock_type],
                                      remark: params[:remark],
                                      fill_clock_mark_time: Time.now,
                                      status: AttendanceNoteState::FILL_CLOCK
                                  })
          render json: {
                     result: true,
                     content: '补打卡成功'
                 }
        else
          render json: {
                     result: false,
                     content: '补打卡日期只能为考勤当天或者后一天！'
                 }
        end

      end

    else
      render :json => {result: false, content: '考勤记录没有找到'}
    end

    # notice = 'Clock Append successfully.'
    # respond_to do |format|
    #   format.html { redirect_to attendance_notes_url, notice: notice }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_note
      @attendance_note = AttendanceNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_note_params
      params.require(:attendance_note).permit(:user_id, :work_date, :status, :on_duty_time, :off_duty_time, :fill_clock_time, :fill_clock_type, :remark, :over_times, :fill_clock_mark_time)
    end
end
