---
layout: default
title: "Blog"
---

<section id="blog" class="py-5 bg-light">
  <div class="container">
    <h1 class="text-center mb-5">Latest Stories</h1>
    <div class="row">
      {% for post in site.posts %}
        <div class="col-md-4 mb-4">
          <div class="card h-100 shadow-sm">
            {% if post.image %}
              <a href="{{ post.url }}">
                <img src="{{ post.image | relative_url }}" class="card-img-top" alt="{{ post.title }}">
              </a>
            {% endif %}
            <div class="card-body">
              <h4 class="card-title">
                <a href="{{ post.url }}" class="text-dark text-decoration-none">{{ post.title }}</a>
              </h4>
              <p class="card-text">{{ post.excerpt }}</p>
              <a href="{{ post.url }}" class="btn btn-primary">Read More</a>
            </div>
          </div>
        </div>
      {% endfor %}
    </div>
  </div>
</section>
