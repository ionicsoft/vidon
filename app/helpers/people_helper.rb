module PeopleHelper
  # Returns an link for the avatar if attached, or a placeholder
  def get_avatar(person)
    if person.avatar.attached?
      url_for(person.avatar)
    else
      "default_profile.jpg"
    end
  end
end
