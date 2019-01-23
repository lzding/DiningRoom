class Order < ApplicationRecord

  include Extensions::UUID

  default_scope { order(order_date: :DESC, user_nr: :ASC) }

  belongs_to :user
  # belongs_to :position_object, class_name: 'Position', foreign_key: :position





  def self.to_xlsx orders
    p = Axlsx::Package.new

    wb = p.workbook
    wb.add_worksheet(:name => "sheet1") do |sheet|
      sheet.add_row ["序号", "日期", "工号", "姓名", "状态"]
      orders.each_with_index do |order, index|
        sheet.add_row [
                          index+1,
                          order.order_date.localtime.strftime('%Y-%m-%d'),
                          order.user.nr,
                          order.user.name,
                          OrderState.display(order.status)
                      ]
      end


    end

    # p.serialize("orders.xlsx")

    p.use_shared_strings = true
    p.to_stream.read

  end


end
