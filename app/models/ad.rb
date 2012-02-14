# encoding: utf-8
class Ad < ActiveRecord::Base
  has_many :ad_prices, :order => 'id desc'
  belongs_to :location

  before_save :set_rate
  after_create :add_price

  validates :ad, :phone, :presence => true

  AD_TYPE    = ['Будинок', '1/2 будинку', '1/3 будинку', '1/4 будинку', 'Котедж', '1/2 котеджу', 'Діл-ку', 'Незав. буд-во', '1-кім. кв-ру', '2-кім. кв-ру', '3-кім. кв-ру']
  #TYPE       = ['Житлові будинки та ділянки під забудову --- В області']
  PRICE_TYPE = ['-', 'у.о.', 'грн.']
  RATE_TYPE  = {-1 => 'v', 0 => "=", 1 => "^"}

  def ad_type_to_s
    AD_TYPE[self.ad_type]
  end

  def price_to_s
    0 == self.price.to_i ? "-" : self.price.to_i
  end

  def price_type_to_s
    PRICE_TYPE[self.price_type.to_i]
  end

  def rate_to_s
    RATE_TYPE[self.rate]
  end

  def set_rate
    unless new_record?
      if self.price_was != self.price
        self.rate = (self.price > self.price_was ? 1 : -1)
        self.add_price
      end
    end
  end

  # if record exists update price if it changes, return false if doesn't
  def self.exist?(attr)
    ad = Ad.find_by_ad_and_phone(attr[:ad], attr[:phone])
    if ad.nil?
      false
    else
      if ad.price != attr[:price] or ad.price_type != attr[:price_type]
        ad.update_attributes(:price => attr[:price], :price_type => attr[:price_type])
      else
        ad.touch
      end
      true
    end
  end

  def add_price
    self.ad_prices.create(:price => self.price, :price_type => self.price_type)
  end

  class Fetch
    attr_accessor :url, :doc, :pages

    require 'hpricot'
    require 'open-uri'
    require 'iconv'

    def initialize(location, page = "")
      @location = location
      get_doc(page)
      #@pages = (@doc/"td[@bgcolor='#e7e7e7']").length
      pages = (@doc/"a[@class='pag']/")
      @pages = pages.blank? ? 0 : Integer(pages.last.to_s)
    end

    def get_doc(page = "")
      #location.title.mb_chars.downcase
      @url = URI.escape(Iconv.conv( 'windows-1251', 'utf-8', "http://vashmagazin.ua/cat/catalog/?#{@location.page_link}&page=#{page}"))
#      @url = URI.escape(Iconv.conv( 'windows-1251', 'utf-8', "http://vashmagazin.ua/cat/catalog/?item_name=#{@location.title}&rubs=0&logic=logic_and&item_price1=від&item_price2=до&page=#{page}"))
      f = open(@url, 'User-Agent' => 'Ruby')
      f.rewind
      @doc = Hpricot(Iconv.conv('utf-8', f.charset, f.readlines.join("\n")))
    end

    def fetch_all
      if 0 == @pages
        parse_data
      else # more than 1 page
        parse_data
        (@pages-1).times do |page|
          get_doc(page+2)
          parse_data
        end
      end
    end

    def parse_data
      (@doc/"div[@style]//strong").each do |title|
        # skip parse Дачі and Попит
        unless (title.parent/"table//td/a/").to_s =~ /Дачі|Попит|Оренда/
          ad_type = title.inner_html.strip
          if AD_TYPE.include?(ad_type)

            pos = (title.parent/"/img").blank? ? 0 : 2
            ad = if (title.parent/"/span[@style]/").blank?
              (title.parent/"/")[2+pos].to_html.gsub(/&nbsp;|\n/, "").strip
            else
              ((title.parent/"/")[2+pos].to_html + (title.parent/"/span/").first.to_html + (title.parent/"/")[4+pos].to_html).gsub(/&nbsp;|\n/, "").strip
            end

            attr = {
              :location_id => @location.id,
              :ad_type => AD_TYPE.index(ad_type),
              :ad => CGI::unescapeHTML(ad),
              :phone => CGI::unescapeHTML((title.parent/"table//td/")[3].to_html.gsub(/&nbsp;|\n|:./, "").to_s.strip),
              :price => ((title.parent/"/strong/")[1].nil? ? 0 : (title.parent/"/strong/")[1].to_html.gsub(/&nbsp;|\n/, "").strip.to_i),
              :price_type => (title.parent/"/span/")[0].nil? ? 0 : PRICE_TYPE.index((title.parent/"/span/").last.to_html.strip)
            }
            pp attr
            Ad.create(attr) unless Ad.exist?(attr)
          end
        end
      end
    end
  end
end
