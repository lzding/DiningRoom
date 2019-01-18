class FillClockType
  ALL_NIGHT = 0
  LEAKAGE = 1

  def self.display type
    case type
      when ALL_NIGHT
        '通宵'
      when LEAKAGE
        '漏打卡'
    end
  end

  def self.find_type str
    case str
      when '午餐'
        LUNCH
      when '晚餐'
        DINNER
    end
  end

  def self.list
    data = []
    self.constants.each do |c|
      v = self.const_get(c.to_s)
      data << [self.display(v),v]
    end
    data
  end
end