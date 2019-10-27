class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  belongs_to :theme, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates_presence_of :theme, :title, :content

  # dennis: Differs from the https://habr.com/en/post/300954/
  after_create :create_post

  def self.pluck_fields
    ["topics.id", "topics.title", "topics.last_post", "topics.posts_count",
     "users.id", "users.name", "themes.id", "themes.title"]
  end

  private
    def create_post
      self.posts.create self.attributes.slice("title", "content", "user_id", "theme_id")
    end
end
