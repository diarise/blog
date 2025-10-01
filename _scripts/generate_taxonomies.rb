#!/usr/bin/env ruby
require 'fileutils'
require 'yaml'

# Paths
categories_dir = "_categories"
tags_dir = "_tags"

FileUtils.mkdir_p(categories_dir)
FileUtils.mkdir_p(tags_dir)

# Collect categories and tags from all posts
categories = []
tags = []

Dir["_posts/*.{md,markdown}"].each do |post_file|
  frontmatter = YAML.load_file(post_file)
  if frontmatter["categories"]
    categories.concat(frontmatter["categories"])
  end
  if frontmatter["tags"]
    tags.concat(frontmatter["tags"])
  end
end

categories.uniq!
tags.uniq!

# Generate category pages
categories.each do |cat|
  filename = "#{categories_dir}/#{cat.downcase.gsub(" ", "-")}.md"
  File.open(filename, "w") do |f|
    f.puts("---")
    f.puts("layout: category")
    f.puts("title: \"#{cat}\"")
    f.puts("category: #{cat}")
    f.puts("permalink: /categories/#{cat.downcase.gsub(" ", "-")}/")
    f.puts("---")
  end
end

# Generate tag pages
tags.each do |tag|
  filename = "#{tags_dir}/#{tag.downcase.gsub(" ", "-")}.md"
  File.open(filename, "w") do |f|
    f.puts("---")
    f.puts("layout: tag")
    f.puts("title: \"#{tag}\"")
    f.puts("tag: #{tag}")
    f.puts("permalink: /tags/#{tag.downcase.gsub(" ", "-")}/")
    f.puts("---")
  end
end

puts "✅ Generated #{categories.size} categories and #{tags.size} tags"
