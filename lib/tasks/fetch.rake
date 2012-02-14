task :fetch_data => :environment do
  Location.all.each do |l|
    ads = Ad::Fetch.new(l)
    ads.fetch_all
    UserMailer.changed_email(ads, l).deliver unless ads.logs.blank?
  end
end
