ThinkingSphinx::Index.define :post, {delta: true} do
  indexes title
  indexes content
  has created_at
end
