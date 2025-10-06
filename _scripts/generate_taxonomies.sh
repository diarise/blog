#!/bin/bash
set -e

echo "🧩 Generating categories and tags..."

mkdir -p _categories _tags

# Collect categories and tags
categories=()
tags=()

# Loop through posts
for post in _posts/*.{md,markdown}; do
  if [ -f "$post" ]; then
    # Extract YAML front matter
    fm=$(awk '/^---/{i++} i==2{exit} i==1' "$post")

    # Extract categories
    while read -r cat; do
      [ -z "$cat" ] && continue
      categories+=("$cat")
    done < <(echo "$fm" | grep "^- " | grep -A50 "categories" | grep -B50 "tags" | grep "^- " | sed 's/^- //')

    # Extract tags
    while read -r tag; do
      [ -z "$tag" ] && continue
      tags+=("$tag")
    done < <(echo "$fm" | grep "^- " | grep -A50 "tags" | sed 's/^- //')
  fi
done

# Remove duplicates
uniq_categories=($(printf "%s\n" "${categories[@]}" | sort -u))
uniq_tags=($(printf "%s\n" "${tags[@]}" | sort -u))

# Helper to slugify text
slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9_-]//g'
}

# Generate category pages
for cat in "${uniq_categories[@]}"; do
  [ -z "$cat" ] && continue
  slug=$(slugify "$cat")
  file="_categories/${slug}.md"
  cat > "$file" <<EOF
---
layout: category
title: "${cat}"
category: ${cat}
permalink: /categories/${slug}/
---
EOF
done

# Generate tag pages
for tag in "${uniq_tags[@]}"; do
  [ -z "$tag" ] && continue
  slug=$(slugify "$tag")
  file="_tags/${slug}.md"
  cat > "$file" <<EOF
---
layout: tag
title: "${tag}"
tag: ${tag}
permalink: /tags/${slug}/
---
EOF
done

echo "✅ Generated ${#uniq_categories[@]} categories and ${#uniq_tags[@]} tags"
