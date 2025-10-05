#!/usr/bin/env ruby
require 'fileutils'
require 'yaml'

puts "🧹 Starting full cleanup..."

# Directories
posts_dir = "_posts"
categories_dir = "_categories"
tags_dir = "_tags"

# Ensure folders exist
[posts_dir, categories_dir, tags_dir].each { |d| FileUtils.mkdir_p(d) }

# Fix post filenames (remove smart quotes & special characters)
Dir["#{posts_dir}/*"].each do |file|
  clean_name = file
    .gsub(/[’‘“”]/, "'")
    .gsub(/[^a-zA-Z0-9\-_\.\/]/, '-')
    .gsub(/--+/, '-')
    .gsub(/-+\.md$/, '.md')

  if file != clean_name
    FileUtils.mv(file, clean_name)
    puts "✅ Renamed: #{File.basename(file)} → #{File.basename(clean_name)}"
  end
end

# Fix YAML frontmatter safely
Dir["#{posts_dir}/*.{md,markdown}"].each do |file|
  content = File.read(file)
  if content =~ /^---\s*\r?\n(.*?)\r?\n---\s*\r?\n/m
    yaml_block = $1
    cleaned_yaml = yaml_block
      .gsub(/\u00A0/, ' ')
      .gsub(/[’‘“”]/, "'")
      .gsub(/\t/, ' ')
      .strip

    # Remove invalid date formats
    cleaned_yaml = cleaned_yaml.gsub(/^date:.*$/, '')

    cleaned_content = content.sub(/^---\s*\r?\n(.*?)\r?\n---\s*\r?\n/m, "---\n#{cleaned_yaml}\n---\n")
    File.write(file, cleaned_content)
  end
end

# Ensure category/tag slugs are lowercase
Dir["#{categories_dir}/*.md"].each do |file|
  next if file.include?(".md")
  filename = File.basename(file, ".md").downcase.gsub(" ", "-")
  new_path = "#{categories_dir}/#{filename}.md"
  FileUtils.mv(file, new_path) if file != new_path
end

Dir["#{tags_dir}/*.md"].each do |file|
  next if file.include?(".md")
  filename = File.basename(file, ".md").downcase.gsub(" ", "-")
  new_path = "#{tags_dir}/#{filename}.md"
  FileUtils.mv(file, new_path) if file != new_path
end

# Remove stray or empty files
[categories_dir, tags_dir].each do |dir|
  Dir["#{dir}/*.md"].each do |file|
    if File.zero?(file) || File.read(file).strip.empty?
      File.delete(file)
      puts "🗑️ Removed empty file: #{file}"
    end
  end
end

puts "✨ Full cleanup completed successfully!"

