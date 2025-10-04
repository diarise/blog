#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'

# Directories for categories and tags
categories_dir = "_categories"
tags_dir = "_tags"

# 🔥 Clean old category & tag pages (avoids dead links)
FileUtils.rm_rf(Dir.glob("#{categories_dir}/*.md"))
FileUtils.rm_rf(Dir.glob("#{tags_dir}/*.md"))

FileUtils.mkdir_p(categories_dir)
FileUtils.mkdir_p(tags_dir)

categories = []
tags = []

# 🔥 Loop through all posts to collect categories and tags
Dir["_posts/*.{md,markdown}"].each do |post_file|
  content = File.read(post_file)

  # Extract YAML front matter
  if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
    raw_frontmatter = $1

    # Remove problematic date/time keys before parsing
    sanitized_frontmatter = raw_frontmatter.gsub(/^date:.*$/, '')

    frontmatter = YAML.safe_load(sanitized_frontmatter, aliases: true) || {}

    categories.concat(Array(frontmatter["categories"])) if frontmatter["categories"]
    tags.concat(Array(frontmatter["tags"])) if frontmatter["tags"]
  end
end

categories.uniq!
tags.uniq!

# 🔥 Generate category pages
categories.each do |cat|
  slug = cat.downcase.strip.gsub(" ", "-")
  File.open("#{categories_dir}/#{slug}.md", "w") do |f|
    f.puts("---")
    f.puts("layout: category")
    f.puts("title: \"#{cat}\"")
    f.puts("category: #{cat}")
    f.puts("permalink: /categories/#{slug}/")
    f.puts("---")
  end
end

# 🔥 Generate tag pages
tags.each do |tag|
  slug = tag.downcase.strip.gsub(" ", "-")
  File.open("#{tags_dir}/#{slug}.md", "w") do |f|
    f.puts("---")
    f.puts("layout: tag")
    f.puts("title: \"#{tag}\"")
    f.puts("tag: #{tag}")
    f.puts("permalink: /tags/#{slug}/")
    f.puts("---")
  end
end

puts "✅ Done! Generated #{categories.size} categories and #{tags.size} tags"
