---
layout: default
title: "Blog"
---

<section id="blog" class="py-5 bg-light">
  <div class="container">
    <div class="text-center mb-5" style="margin-top: 3rem!important;">
                <h2 class="text-uppercase font-weight-bold">LATEST STORIES</h2>
                <p class="text-muted">Enjoy th reading!</p>
            </div>
    <div class="row">
      {% for post in site.posts %}
        <div class="col-md-6 col-lg-4 mb-4">
          <div class="card h-100 shadow-sm">
            {% if post.image %}
              <a href="{{ post.url }}">
                <img src="{{ post.image | relative_url }}" class="card-img-top" alt="{{ post.title }}">
              </a>
            {% endif %}
            <div class="card-body">
              <h4 class="card-title">
                <a href="{{ post.url }}" class="text-dark">{{ post.title }}</a>
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
