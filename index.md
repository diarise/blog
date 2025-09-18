---
layout: default
title: "Blog"
---

<h1>Latest Posts</h1>

<ul class="posts">
  {% for post in site.posts %}
    <li>
      <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
      {% if post.image %}
        <img src="{{ post.image }}" alt="{{ post.title }}" style="max-width:300px;">
      {% endif %}
      <p>{{ post.excerpt }}</p>
      <a href="{{ post.url }}">Read more →</a>
    </li>
  {% endfor %}
</ul>
