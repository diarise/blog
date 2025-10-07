# _scripts/generate_taxonomies.rb
require 'fileutils'
require 'yaml'
require 'unicode_normalize'

POSTS_DIR = "_posts"
CATEGORIES_DIR = "_categories"
TAGS_DIR = "_tags"

# Clean and recreate category/tag folders
FileUtils.mkdir_p(CATEGORIES_DIR)
FileUtils.mkdir_p(TAGS_DIR)

# Helper: sanitize strings for filenames and URLs
def slugify(text)
  text.downcase.unicode_normalize(:nfkd).encode('ASCII', replace: '').gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '')
end

categories = Set.new
tags = Set.new

# Collect categories and tags from posts
Dir.glob("#{POSTS_DIR}/*.md") do |post|
  front_matter = YAML.load_file(post)
  next unless front_matter.is_a?(Hash)
  categories.merge(front_matter["categories"] || [])
  tags.merge(front_matter["tags"] || [])
end

# Generate markdown files for each category
categories.each do |category|
  slug = slugify(category)
  path = File.join(CATEGORIES_DIR, "#{slug}.md")
  File.write(path, <<~MD)
    ---
    layout: category
    title: "#{category}"
    permalink: /categories/#{slug}/
    category: #{category}
    ---
  MD
end

# Generate markdown files for each tag
tags.each do |tag|
  slug = slugify(tag)
  path = File.join(TAGS_DIR, "#{slug}.md")
  File.write(path, <<~MD)
    ---
    layout: tag
    title: "#{tag}"
    permalink: /tags/#{slug}/
    tag: #{tag}
    ---
  MD
end

puts "✅ Generated #{categories.size} categories and #{tags.size} tags."
