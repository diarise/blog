---
layout: default
title: "Blog"
---

<section id="blog" class="container">
  <h1 class="text-center mb-5">Latest Stories</h1>
  <div class="row">
    {% for post in site.posts %}
      <div class="col-md-4 mb-4">
        <div class="card h-100">
          {% if post.image %}
            <img src="{{ post.image | relative_url }}" class="card-img-top" alt="{{ post.title }}">
          {% endif %}
          <div class="card-body">
            <h4 class="card-title"><a href="{{ post.url }}">{{ post.title }}</a></h4>
            <p class="card-text">{{ post.excerpt }}</p>
            <a href="{{ post.url }}" class="btn btn-primary">Read More</a>
          </div>
        </div>
      </div>
    {% endfor %}
  </div>
</section>
