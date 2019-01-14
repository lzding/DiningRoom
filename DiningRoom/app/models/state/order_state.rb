class OrderState
  INIT = 0
  ORDERED = 1

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
        '未订餐'
      when ORDERED
        '已订餐'
    end
  end
end