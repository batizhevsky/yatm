module ApplicationHelper
  def status_icon(user)
    if user.online?
      image_tag('online.png', size: '16x16', alt: 'online')
    else
      image_tag('offline.png', size: '16x16', alt: 'offline')
    end
  end
end
