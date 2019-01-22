module FileHandler
  module Excel
    class UserHandler<Base
      IMPORT_HEADERS=[
          :nr, :name, :role_id
      ]

      def self.import(file)
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
                row[:role_id]=Role.find_role_num(row[:role_id])
                row[:role_id]=Role.manager if row[:role_id]==Role.admin

                menu = User.new({
                                    nr: row[:nr],
                                    name: row[:name],
                                    role_id: row[:role_id],
                                    password: '123456@',
                                    password_confirmation: '123456@'
                                })

                menu.save
              end
            end
            msg.result = true
            msg.content = "导入员工信息成功"
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
        if row[:nr].blank?
          msg.contents << "工号:#{row[:nr]} 不能为空!"
        end

        if row[:name].blank?
          msg.contents << "姓名:#{row[:name]} 不能为空!"
        end

        if row[:role_id].blank?
          msg.contents << "角色不能为空!"
        else
          if Role.find_role_num(row[:role_id]).blank?
            msg.contents << "角色输入不正确，请选择【系统管理员/管理员/员工】!"
          end
        end

        #check uniq
        if msg.contents.size==0
          unless User.where(nr: row[:nr]).blank?
            msg.contents << "该工号【#{row[:nr]}】已存在!"
          else
            if unique_key.include?("#{row[:nr]}")
              msg.contents << "该工号【#{row[:nr]}】已重复!"
            else
              unique_key<<"#{row[:nr]}"
            end
          end
        end

        unless msg.result=(msg.contents.size==0)
          msg.content=msg.contents.join('/')
        end
        msg
      end



    end
  end
end
