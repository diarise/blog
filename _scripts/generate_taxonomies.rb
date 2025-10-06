#!/usr/bin/env ruby
require 'fileutils'
require 'yaml'
require 'date'
require 'time'

# Paths
categories_dir = "_categories"
tags_dir = "_tags"

FileUtils.mkdir_p(categories_dir)
FileUtils.mkdir_p(tags_dir)

# Collect categories and tags from all posts
categories = []
tags = []

Dir["_posts/*.{md,markdown}"].each do |post_file|
  content = File.read(post_file)

  # Extract YAML front matter
  if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
    raw_frontmatter = $1

    # Remove date/time keys before parsing
    sanitized_frontmatter = raw_frontmatter.gsub(/^date:.*$/, '')

    frontmatter = YAML.safe_load(sanitized_frontmatter, permitted_classes: [Date, Time], aliases: true) || {}

    categories.concat(Array(frontmatter["categories"])) if frontmatter["categories"]
    tags.concat(Array(frontmatter["tags"])) if frontmatter["tags"]
  end
end

categories.uniq!
tags.uniq!

# Generate category pages
categories.each do |cat|
  slug = cat.downcase.strip.gsub(" ", "-")
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
  slug = tag.downcase.strip.gsub(" ", "-")
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

puts "✅ Generated #{categories.size} categories and #{tags.size} tags"
