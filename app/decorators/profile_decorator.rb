class ProfileDecorator < Draper::Decorator
  delegate_all

  def name
    if object.name.nil?
      'Unknown'
    else
      object.name
    end
  end

  def profile_image
    if object.avatar.url.nil?
      h.fa_stacked_icon( "user", base: 'circle-o')
    else
      h.image_tag(object.avatar.url, class: 'img-circle avatar')
    end
  end

  def profile_image_small
    if object.avatar.url.nil?
      h.fa_stacked_icon( "user", base: 'circle-o')
    else
      h.image_tag(object.avatar.url, class: 'img-circle avatar-sm')
    end
  end

  def twitter_link
    if(!object.twitter.nil?)
      'https://www.twitter.com/' + object.twitter
    end
  end

  def facebook_link
    if(!object.facebook.nil?)
    'https://www.facebook.com/' + object.facebook
    end
  end

  def instagram_link
    if(!object.instagram.nil?)
    'http://www.instagram.com/' + object.instagram
    end
  end

end
