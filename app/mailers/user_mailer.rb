class UserMailer < ActionMailer::Base
  default :from => "info@nahaylo.com"

  def changed_email(ads, location)
    @location = location
    @logs     = ads.logs
    mail(:to => 'nahaylo@gmail.com', :subject => "Нові дані по оголошенням в #{location.title}")
  end
end
