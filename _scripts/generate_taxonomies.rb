#!/usr/bin/env ruby
require 'fileutils'
require 'yaml'
require 'cgi'

# Paths
categories_dir = "_categories"
tags_dir = "_tags"

FileUtils.mkdir_p(categories_dir)
FileUtils.mkdir_p(tags_dir)

# Helper: sanitize slugs safely
def safe_slug(text)
  return "" if text.nil?
  text.encode('UTF-8', invalid: :replace, undef: :replace, replace: '') # strip invalid bytes
      .downcase
      .strip
      .gsub(/[’'`"“”]/, '')          # remove quotes
      .gsub(/[^a-z0-9\s_-]/, '')     # only safe chars
      .gsub(/\s+/, '-')              # replace spaces with dash
      .gsub(/-+/, '-')               # no double dashes
end

categories = []
tags = []

Dir["_posts/*.{md,markdown}"].each do |post_file|
  # Rename file if it contains invalid chars
  base = File.basename(post_file, ".*")
  clean_name = safe_slug(base)
  new_path = File.join("_posts", "#{clean_name}.md")
  if new_path != post_file
    FileUtils.mv(post_file, new_path)
    post_file = new_path
  end

  content = File.read(post_file)
  if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
    raw_frontmatter = $1
    sanitized_frontmatter = raw_frontmatter.gsub(/^date:.*$/, '')
    frontmatter = YAML.safe_load(sanitized_frontmatter, aliases: true) || {}

    categories.concat(Array(frontmatter["categories"])) if frontmatter["categories"]
    tags.concat(Array(frontmatter["tags"])) if frontmatter["tags"]
  end
end

categories.uniq!
tags.uniq!

# Generate category pages
categories.each do |cat|
  slug = safe_slug(cat)
  next if slug.empty?
  filename = "#{categories_dir}/#{slug}.md"
  File.open(filename, "w") do |f|
    f.puts("---")
    f.puts("layout: category")
    f.puts("title: \"#{cat}\"")
    f.puts("category: #{cat}")
    f.puts("permalink: /categories/#{slug}/")
    f.puts("---")
  end
end

# Generate tag pages
tags.each do |tag|
  slug = safe_slug(tag)
  next if slug.empty?
  filename = "#{tags_dir}/#{slug}.md"
  File.open(filename, "w") do |f|
    f.puts("---")
    f.puts("layout: tag")
    f.puts("title: \"#{tag}\"")
    f.puts("tag: #{tag}")
    f.puts("permalink: /tags/#{slug}/")
    f.puts("---")
  end
end

puts "✅ Generated #{categories.size} categories and #{tags.size} tags (filenames sanitized safely)"
