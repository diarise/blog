{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # _scripts/generate_taxonomies.rb\
require 'yaml'\
require 'fileutils'\
\
# Paths\
categories_dir = "_categories"\
tags_dir = "_tags"\
\
# Ensure dirs exist\
FileUtils.mkdir_p(categories_dir)\
FileUtils.mkdir_p(tags_dir)\
\
# Collect categories and tags\
categories = []\
tags = []\
\
Dir["_posts/*"].each do |post_file|\
  content = File.read(post_file)\
  if content =~ /^---(.+?)---/m\
    front_matter = YAML.safe_load($1)\
    categories.concat(Array(front_matter["categories"])) if front_matter["categories"]\
    tags.concat(Array(front_matter["tags"])) if front_matter["tags"]\
  end\
end\
\
# Deduplicate\
categories.uniq!\
tags.uniq!\
\
# Generate category pages\
categories.each do |cat|\
  filename = "#\{categories_dir\}/#\{cat.downcase.gsub(" ", "-")\}.md"\
  File.open(filename, "w") do |f|\
    f.puts <<~HEREDOC\
    ---\
    layout: category\
    title: "#\{cat\}"\
    permalink: /categories/#\{cat.downcase.gsub(" ", "-")\}/\
    ---\
    HEREDOC\
  end\
end\
\
# Generate tag pages\
tags.each do |tag|\
  filename = "#\{tags_dir\}/#\{tag.downcase.gsub(" ", "-")\}.md"\
  File.open(filename, "w") do |f|\
    f.puts <<~HEREDOC\
    ---\
    layout: tag\
    title: "#\{tag\}"\
    permalink: /tags/#\{tag.downcase.gsub(" ", "-")\}/\
    ---\
    HEREDOC\
  end\
end\
\
puts "\uc0\u9989  Generated #\{categories.size\} categories and #\{tags.size\} tags."}
require 'yaml'
require 'fileutils'

# Paths
categories_dir = "_categories"
tags_dir = "_tags"

# Ensure dirs exist
FileUtils.mkdir_p(categories_dir)
FileUtils.mkdir_p(tags_dir)

# Collect categories and tags
categories = []
tags = []

Dir["_posts/*"].each do |post_file|
  content = File.read(post_file)
  if content =~ /^---(.+?)---/m
    front_matter = YAML.safe_load($1)
    categories.concat(Array(front_matter["categories"])) if front_matter["categories"]
    tags.concat(Array(front_matter["tags"])) if front_matter["tags"]
  end
end

# Deduplicate
categories.uniq!
tags.uniq!

# Generate category pages
categories.each do |cat|
  filename = "#{categories_dir}/#{cat.downcase.gsub(" ", "-")}.md"
  File.open(filename, "w") do |f|
    f.puts <<~HEREDOC
    ---
    layout: category
    title: "#{cat}"
    permalink: /categories/#{cat.downcase.gsub(" ", "-")}/
    ---
    HEREDOC
  end
end

# Generate tag pages
tags.each do |tag|
  filename = "#{tags_dir}/#{tag.downcase.gsub(" ", "-")}.md"
  File.open(filename, "w") do |f|
    f.puts <<~HEREDOC
    ---
    layout: tag
    title: "#{tag}"
    permalink: /tags/#{tag.downcase.gsub(" ", "-")}/
    ---
    HEREDOC
  end
end

puts "✅ Generated #{categories.size} categories and #{tags.size} tags."
