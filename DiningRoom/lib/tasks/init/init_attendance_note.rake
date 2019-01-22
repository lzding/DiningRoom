require 'active_support/core_ext/string/date'
namespace :init_attendance_note do
  desc "init attendance note for everybody at 00:30 per day"

  task :create, [:work_date] => :environment do |t, args|
    puts 'start create attendance note'
    work_date = DateTime.now.at_beginning_of_day
    unless args[:work_date].blank?
      raise 'Err Msg : Work Date is not right.' unless args[:work_date].is_date?
      work_date = DateTime.parse(args[:work_date]).localtime.at_beginning_of_day
    end
    puts work_date

    AttendanceNote.transaction do

      User.all.each do |user|
        puts '-------------------------------'
        puts user.nr
        puts '-------------------------------'
        AttendanceNote.create({
                                  user_id: user.id,
                                  work_date: work_date,
                                  status: AttendanceNoteState::INIT
                              })
      end

    end

    puts 'end create attendance note'
  end



end

