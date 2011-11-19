task :fetch_data => :environment do
  Location.all.each do |l|
    ads = Ad::Fetch.new(l)
    ads.fetch_all
  end
end

task :fetch_data_old => :environment do
  require 'hpricot'
  require 'open-uri'
  require 'iconv'

  url = URI.escape(Iconv.conv( 'windows-1251', 'utf-8', "http://vashmagazin.ua/cat/catalog/?item_name=пасіки&rubs=0&logic=logic_and&item_price1=від&item_price2=до&page=1"))
  #puts url
  #exit
  #url = "http://vashmagazin.ua/cat/catalog/?item_name=%EF%E0%F1%B3%EA%E8&rubs=0&logic=logic_and&item_price1=%E2%B3%E4&item_price2=%E4%EE&page=1"

  #headers = {
  #  'User-Agent' => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1'
  #}
  #source = Net::HTTP.get('vashmagazin.ua', '/cat/catalog/?item_name=%EF%E0%F1%B3%EA%E8&rubs=0&logic=logic_and&item_price1=%E2%B3%E4&item_price2=%E4%EE&page=1', headers)
  #
  #puts source


  #html = open(url, 'User-Agent' => 'Ruby').read
  #puts html

  #doc = open(url)
  #
  #puts doc.to_s

  f = open(url, 'User-Agent' => 'Ruby')
  f.rewind
  doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))

  puts f.charset

  #(doc/"td[@bgcolor='#e7e7e7']").length

  #doc = open(url, 'User-Agent' => 'Ruby') { |f| Hpricot(f) }

  #puts doc

  #puts (doc/"//div[@style='margin-top:8px; padding:3px;']").first#.inner_html

  (doc/"div[@style]//strong").each do |title|
    if ['Діл-ку'].include? title.inner_html
      #puts "-#{(title.parent/"/")[2].to_s.gsub(/&nbsp;/, "=")}-"
      puts (title.parent/"/")[2].to_html.gsub(/&nbsp;|\n/, "").strip
      #puts (title.parent/"table//td/strong/")
      puts 'Телефон'
      puts (title.parent/"table//td/")[3].to_html.gsub(/&nbsp;|\n|:./, "").strip
      puts 'Ціна'
      puts (title.parent/"/strong/")[1].to_html.gsub(/&nbsp;|\n/, "").strip.to_i
      puts 'Одиниці'
      puts (title.parent/"/span/")[0].to_html.strip
      puts ""
    end
    #puts title.parent
  end
  #(doc/"div").each do |table|#[5]
  ##
  #puts table
  #end

  #data = (table/"/tr/td")[2]
  #
  #puts data

  #elements = doc.search("/html/body//div[@style]")
  #puts elements.length
end