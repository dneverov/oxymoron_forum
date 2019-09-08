class Post < ApplicationRecord
  belongs_to :topic, :counter_cache => true
  belongs_to :theme, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates :content, presence: true, length: { in: 2..300 }

  after_create :set_last_post

  def self.look_for query
    return self if query.blank? or query.length < 3
    search_ids = self.search_for_ids(query, {per_page: 1000, order: 'created_at DESC'})
    self.where(id: search_ids)
  end

  private
    def set_last_post
      last_post = self.as_json(include: [:topic, :user])
      topic.update(last_post: last_post)
      theme.update(last_post: last_post)
    end
end
