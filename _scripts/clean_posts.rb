#!/usr/bin/env ruby
require 'fileutils'

puts "🧹 Running pre-cleanup on post files..."

# Fix filenames
Dir["_posts/*"].each do |file|
  clean_name = file
    .gsub(/[’‘“”]/, "'")       # replace smart quotes
    .gsub(/[^a-zA-Z0-9\-_\.\/]/, '-') # replace weird chars with hyphens

  if file != clean_name
    FileUtils.mv(file, clean_name)
    puts "✅ Renamed: #{File.basename(file)} → #{File.basename(clean_name)}"
  end
end

# Fix frontmatter YAML format
Dir["_posts/*.{md,markdown}"].each do |file|
  content = File.read(file)

  # Normalize YAML boundaries
  if content =~ /^---\s*\r?\n(.*?)\r?\n---\s*\r?\n/m
    yaml_block = $1
    cleaned_yaml = yaml_block
      .gsub(/\u00A0/, ' ')      # remove non-breaking spaces
      .gsub(/[’‘“”]/, "'")     # fix smart quotes
      .gsub(/\t/, ' ')          # replace tabs
      .strip

    cleaned_content = content.sub(/^---\s*\r?\n(.*?)\r?\n---\s*\r?\n/m, "---\n#{cleaned_yaml}\n---\n")
    File.write(file, cleaned_content)
  end
end

# Clean empty markdown files
Dir["_categories/.md", "_tags/.md"].each do |bad_file|
  if File.exist?(bad_file)
    File.delete(bad_file)
    puts "🗑️ Removed stray file: #{bad_file}"
  end
end

puts "✨ Cleanup complete!"
