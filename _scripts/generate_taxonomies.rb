#!/usr/bin/env ruby
require 'fileutils'
require 'yaml'

# Define paths
categories_dir = "_categories"
tags_dir = "_tags"
posts_dir = "_posts"

FileUtils.mkdir_p(categories_dir)
FileUtils.mkdir_p(tags_dir)

# Simple slug generator (ASCII only)
def safe_slug(text)
  return "" if text.nil?
  text.to_s.downcase.strip
      .gsub(/[’'`"“”]/, '')      # remove quotes
      .gsub(/[^a-z0-9\s_-]/, '') # strip weird chars
      .gsub(/\s+/, '-')          # spaces to hyphens
      .gsub(/-+/, '-')           # no double dashes
end

categories = []
tags = []

Dir["#{posts_dir}/*.{md,markdown}"].each do |post_file|
  begin
    content = File.read(post_file)
    if content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      raw_frontmatter = $1
      sanitized_frontmatter = raw_frontmatter.gsub(/^date:.*$/, '')
      frontmatter = YAML.safe_load(sanitized_frontmatter, aliases: true) || {}

      categories.concat(Array(frontmatter["categories"])) if frontmatter["categories"]
      tags.concat(Array(frontmatter["tags"])) if frontmatter["tags"]
    end
  rescue => e
    puts "⚠️ Skipping file #{post_file}: #{e.message}"
  end
end

categories.uniq!
tags.uniq!

# Create category pages
categories.each do |cat|
  slug = safe_slug(cat)
  next if slug.empty?
  path = "#{categories_dir}/#{slug}.md"
  File.open(path, "w") do |f|
    f.puts("---")
    f.puts("layout: category")
    f.puts("title: \"#{cat}\"")
    f.puts("category: #{cat}")
    f.puts("permalink: /categories/#{slug}/")
    f.puts("---")
  end
end

# Create tag pages
tags.each do |tag|
  slug = safe_slug(tag)
  next if slug.empty?
  path = "#{tags_dir}/#{slug}.md"
  File.open(path, "w") do |f|
    f.puts("---")
    f.puts("layout: tag")
    f.puts("title: \"#{tag}\"")
    f.puts("tag: #{tag}")
    f.puts("permalink: /tags/#{slug}/")
    f.puts("---")
  end
end

puts "✅ Successfully generated #{categories.size} categories and #{tags.size} tags."

