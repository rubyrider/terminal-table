%w(cell row separator style table table_helper version).each do |file|
  require "db-table/#{file}"
end