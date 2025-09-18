---
layout: default
title: "Blog"
---

<h1>Latest Posts</h1>

<div class="posts-list">
  {% for post in site.posts %}
    <article class="post-card">
      {% if post.image %}
        <a href="{{ post.url }}">
          <img class="post-thumb" src="{{ post.image | relative_url }}" alt="{{ post.title }}">
        </a>
      {% endif %}
      
      <div class="post-info">
        <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
        <p class="post-meta">{{ post.date | date: "%B %d, %Y" }}</p>
        <p>{{ post.excerpt }}</p>
        <a class="read-more" href="{{ post.url }}">Read more →</a>
      </div>
    </article>
  {% endfor %}
</div>
