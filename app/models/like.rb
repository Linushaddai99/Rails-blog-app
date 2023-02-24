class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def likes_counter
    post.increments!(:likes_counter)
  end
end
