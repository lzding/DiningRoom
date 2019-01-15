module FileHandler
  module Excel
    class MenuHandler<Base
      IMPORT_HEADERS=[
          :dinner_date, :dinner_type, :dish_one, :dish_two, :dish_three, :soup
      ]

      def self.import(file, user)
        puts '---------------------------------------'
        puts file
        puts '---------------------------------------'

        msg = Message.new
        book = Roo::Excelx.new file.full_path
        book.default_sheet = book.sheets.first

        validate_msg = validate_import(file)
        if validate_msg.result
          begin
            Menu.transaction do

              2.upto(book.last_row) do |line|
                row = {}
                IMPORT_HEADERS.each_with_index do |k, i|
                  row[k] = book.cell(line, i+1).to_s.strip
                end
                row[:dinner_date]=Date.parse(row[:dinner_date])
                row[:dinner_type]=MenuType.find_type(row[:dinner_type])
                puts '---------------row-----------------'
                puts row

                menu = Menu.new({
                                    dinner_date: row[:dinner_date],
                                    dinner_type: row[:dinner_type],
                                    dish_one: row[:dish_one],
                                    dish_two: row[:dish_two],
                                    dish_three: row[:dish_three],
                                    soup: row[:soup]
                                })

                menu.save
              end
            end
            msg.result = true
            msg.content = "导入菜单成功"
          rescue => e
            puts e.backtrace
            msg.result = false
            msg.content = e.message
          end
        else
          msg.result = false
          msg.content = validate_msg.content
        end

        msg
      end

      def self.validate_import file
        tmp_file=full_tmp_path(file.oriName)
        msg = Message.new(result: true)
        book = Roo::Excelx.new file.full_path
        book.default_sheet = book.sheets.first

        p = Axlsx::Package.new
        p.workbook.add_worksheet(:name => "Basic Worksheet") do |sheet|
          sheet.add_row IMPORT_HEADERS+['Error Msg']
          #validate file
          2.upto(book.last_row) do |line|
            row = {}
            IMPORT_HEADERS.each_with_index do |k, i|
              row[k] = book.cell(line, i+1).to_s.strip
              # row[k]=row[k].sub(/\.0/, '') if k== :user_id
            end

            unique_key = []
            mssg = validate_import_row(row, line, unique_key)
            if mssg.result
              sheet.add_row row.values
            else
              if msg.result
                msg.result = false
                msg.content = "下载错误文件<a href='/files/#{Base64.urlsafe_encode64(tmp_file)}'>#{::File.basename(tmp_file)}</a>"
              end
              sheet.add_row row.values<<mssg.content
            end
          end
        end
        puts '-------------------------------------'
        p.use_shared_strings = true
        p.serialize(tmp_file)
        msg
      end

      def self.validate_import_row(row, line, unique_key)
        msg = Message.new(contents: [])
        if row[:dinner_date].present?
          unless is_date?(row[:dinner_date])
            msg.contents << "日期:#{row[:dinner_date]} 不合法!"
          end
        else
          msg.contents << "日期:#{row[:dinner_date]} 不能为空!"
        end

        if row[:dinner_type].blank?
          msg.contents << "菜单类型不能为空!"
        else
          if MenuType.find_type(row[:dinner_type]).blank?
            msg.contents << "菜单类型不正确，请选择【午餐/晚餐】!"
          end
        end

        #check uniq
        if msg.contents.size==0
          unless Menu.where(dinner_date: Date.parse(row[:dinner_date]), dinner_type: MenuType.find_type(row[:dinner_type])).blank?
            msg.contents << "该日期【#{row[:dinner_date]}】类型【#{row[:dinner_type]}】菜单已存在!"
          else
            if unique_key.include?("#{row[:dinner_date]}#{row[:dinner_type]}")
              msg.contents << "该日期【#{row[:dinner_date]}】类型【#{row[:dinner_type]}】菜单已重复!"
            else
              unique_key<<"#{row[:dinner_date]}#{row[:dinner_type]}"
            end
          end
        end

        if row[:dish_one].blank?
          msg.contents << "菜 1 不能为空!"
        end

        if row[:dish_two].blank?
          msg.contents << "菜 2 不能为空!"
        end

        unless msg.result=(msg.contents.size==0)
          msg.content=msg.contents.join('/')
        end
        msg
      end

      def self.is_date?(str)
        true if Date.parse(str) && Time.parse(str) rescue false
      end


    end
  end
end
