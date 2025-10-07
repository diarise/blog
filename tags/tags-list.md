---
layout: default
title: "All Tags"
permalink: /all-tags/
---

<section id="tags" class="py-5">
  <div class="container">
    <h1 class="text-center mb-4 font-weight-bold">🏷️ Browse by Tag</h1>
    <p class="text-center text-muted mb-5">
      Click a tag to discover related travel stories and experiences.
    </p>

    <div class="tag-list text-center">
      {% assign sorted_tags = site.tags | sort %}
      {% for tag in sorted_tags %}
        {% assign tag_name = tag[0] %}
                <a href="/tags/{{ tag_name | slugify }}/" 
           class="badge badge-lg tag-badge m-2 px-3 py-2">
          {{ tag_name }} ({{ tag[1].size }})
        </a>
      {% endfor %}
    </div>
  </div>
</section>
