class Excelsheet < ActiveRecord::Base
  attr_accessible :id, :excelsheet_file

  has_attached_file :excelsheet_file

  #validates_format_of :excelsheet_file, :with => %r{\.(xls|xlsx)$}i

  after_save :dump_to_table

  def dump_to_table
     require 'roo'
     file = self.excelsheet_file.path
     extension = File.extname(file)
     excel_file(file, extension).each_with_index { |row,index|
        next if (index == 0)
        Document.dump(row,id)
     }

  end

  def excel_file(file, extension)
  	case extension
      when '.xls' then Roo::Excel.new(file)
      when '.xlsx' then Roo::Excelx.new(file) 
    end
  end

end
