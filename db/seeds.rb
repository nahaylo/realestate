# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

["Пасіки", "Солонка", "Сокільники", "Зубра", "новобуд"].each do |l|
  Location.find_or_create_by_title l
end

[
  ["Житло в новобудовах", [100, 2]],
  
  ["Сихів - 3 кімнатні", [106, 6]],
  ["Сихів - 2 кімнатні", [104, 6]],
  ["Сихів - 1 кімнатні", [102, 6]],
  
  ["Франківський - 3 кімнатні", [106, 2]],
  ["Франківський - 2 кімнатні", [104, 2]],
  ["Франківський - 1 кімнатні", [102, 2]]
].each do |name, page|
  Location.find_or_create_by_title_and_page_id_and_page_sub_id name, page.first, page.last
end
