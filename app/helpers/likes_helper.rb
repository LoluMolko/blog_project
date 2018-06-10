module LikesHelper
  def liked_message(model)
    pluralization = pluralize(model.likes_count, 'person')
    message = "liked this #{model.class.name.downcase}"
    "#{pluralization} #{message}"
  end
end
