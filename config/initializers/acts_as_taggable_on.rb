ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId
  friendly_id :name,
              :use => :slugged,
              :reserved_words => ['show', 'edit', 'create', 'update', 'destroy']

  %w(skills interests).each do |scoped|
    scope scoped, -> { select('distinct(tags.name), *').joins(:taggings).where('taggings.context = ?', scoped) }
  end
end
