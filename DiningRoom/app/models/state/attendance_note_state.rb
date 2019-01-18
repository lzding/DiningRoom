class AttendanceNoteState
  INIT = 0
  ON_DUTY = 10
  OFF_DUTY = 20
  FILL_CLOCK = 30

  def self.list
    data = []
    self.constants.each do |c|
      v = self.const_get(c.to_s)
      data << [self.display(v),v]
    end
    data
  end

  def self.all
    self.constants.collect{|c| self.const_get(c.to_s)}
  end

  def self.display state
    case state.to_i
      when INIT
        '未上班'
      when ON_DUTY
        '工作中'
      when OFF_DUTY
        '已下半'
      when FILL_CLOCK
        '补打卡'
    end
  end
end