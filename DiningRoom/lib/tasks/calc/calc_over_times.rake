namespace :calc_attendance_note do
  desc "calc over times on attendance notes"

  task :calc, [:calc_all] => :environment do |t, args|
    puts 'start calc attendance notes'

    calc_all = false
    if args[:calc_all].present? && args[:calc_all] == 'Y'
      puts 'Re Calc All Attendance Notes.'
      calc_all = true
    else
      puts 'Just Calc Attendance Notes Without Over Times.'
    end

    count = 0
    AttendanceNote.transaction do

      AttendanceNote.all.each do |note|
        next if note.off_duty_time.blank? && note.fill_clock_time.blank?

        next if !calc_all && !note.over_times.blank?

        count += 1
        note.update({over_times: note.calc_over_times(note.fill_clock_time.blank? ? note.off_duty_time : note.fill_clock_time)})
      end

    end

    puts "end calc attendance notes, Calc Count【#{count}】"
  end


end