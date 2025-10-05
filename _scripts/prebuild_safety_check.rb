#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'

puts "🧩 Running prebuild safety checks..."

# 1️⃣ Check includes that are used but missing
includes = %w[
  _includes/share.html
  _includes/author.html
  _includes/newsletter.html
  _includes/cta.html
]

includes.each do |inc|
  unless File.exist?(inc)
    puts "⚠️ Missing include: #{inc}. Creating empty placeholder..."
    FileUtils.mkdir_p(File.dirname(inc))
    File.write(inc, "<!-- Auto-created placeholder for #{File.basename(inc)} -->\n")
  end
end

# 2️⃣ Check all layout files for infinite loops
Dir["_layouts/*.html"].each do |layout|
  content = File.read(layout)
  if content.include?("layout: #{File.basename(layout, '.html')}")
    puts "🚨 Infinite layout loop detected in #{layout}, removing layout reference..."
    fixed = content.gsub(/^---\nlayout:.*\n---/, "---\n---")
    File.write(layout, fixed)
  end
end

# 3️⃣ Normalize all permalinks in _categories & _tags
def normalize_permalinks(folder, key)
  Dir["#{folder}/*.md"].each do |file|
    data = File.read(file)
    fixed = data.gsub(%r{permalink:\s*/?#{folder}[-/]}, "permalink: /#{folder}/")
    File.write(file, fixed) if data != fixed
  end
end

normalize_permalinks("_categories", "category")
normalize_permalinks("_tags", "tag")

# 4️⃣ Sanity check: no empty layout references
Dir["_posts/*.md"].each do |file|
  content = File.read(file)
  if content =~ /^layout:\s*$/i
    puts "⚠️ Empty layout in #{file}, setting to 'post'"
    content = content.gsub(/^layout:\s*$/i, "layout: post")
    File.write(file, content)
  end
end

puts "✅ Prebuild safety check completed."
