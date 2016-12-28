class ImportService

  def initialize klass
    @model = klass
  end

  def import file
    spreadsheet = open_spreadsheet file
    header = spreadsheet.row 1
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      data = @model.find_by_id(row["id"]) || @model.new
      data.attributes = row.to_hash.slice(*row.to_hash.keys)
      data.save!
    end
  end

  def open_spreadsheet file
    case File.extname file.original_filename
    when ".csv" then Roo::CSV.new file.path
    when ".xlsx" then Roo::Excelx.new file.path
    else raise t("unknown_file_type", ext: file.original_filename)
    end
  end
end
