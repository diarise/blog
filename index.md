---
layout: default
title: "Blog"
---

<section id="blog" class="py-5 bg-light">
  <div class="container">

    <!-- Featured Post -->
    {% assign featured = site.posts.first %}
    <div class="row mb-5 align-items-center">
      <div class="col-md-6">
        {% if featured.image %}
          <a href="{{ featured.url }}">
            <img src="{{ featured.image | relative_url }}" alt="{{ featured.title }}" class="img-fluid rounded shadow-sm">
          </a>
        {% endif %}
      </div>
      <div class="col-md-6">
        <h2 class="mb-3">{{ featured.title }}</h2>
        <p class="text-muted">{{ featured.date | date: "%B %d, %Y" }}</p>
        <p>{{ featured.excerpt }}</p>
        <a href="{{ featured.url }}" class="btn btn-primary">Read More</a>
      </div>
    </div>

    <!-- Remaining Posts -->
    <div class="text-center mb-5" style="margin-top: 3rem!important;">
                <h3 class="text-uppercase font-weight-bold">LATEST STORIES</h3>
                <p class="text-muted">Enjoy th reading!</p>
            </div>
    <div class="row">
      {% for post in site.posts offset:1 %}
        <div class="col-md-6 col-lg-4 mb-4">
          <div class="card h-100 shadow-sm">
            {% if post.image %}
              <a href="{{ post.url }}">
                <img src="{{ post.image | relative_url }}" class="card-img-top" alt="{{ post.title }}">
              </a>
            {% endif %}
            <div class="card-body">
              <h5 class="card-title">
                <a href="{{ post.url }}" class="text-dark">{{ post.title }}</a>
              </h5>
              <p class="card-text">{{ post.excerpt }}</p>
              <a href="{{ post.url }}" class="btn btn-outline-primary btn-sm">Read More</a>
            </div>
          </div>
        </div>
      {% endfor %}
    </div>

  </div>
</section>
