class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  def likes_counter
    post.increments!(:likes_counter)
  end
end
