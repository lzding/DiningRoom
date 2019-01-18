class AttendanceNotesController < ApplicationController
  before_action :set_attendance_note, only: [:show, :edit, :update, :destroy]

  # GET /attendance_notes
  # GET /attendance_notes.json
  def index
    @attendance_notes = AttendanceNote.paginate(:page => params[:page])
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
