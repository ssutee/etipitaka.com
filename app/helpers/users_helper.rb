module UsersHelper
  def gravatar_for(user, options = { :size => 20 })
    gravatar_image_tag(user.email.downcase, :alt => user.user_name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
