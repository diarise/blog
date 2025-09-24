---
layout: default
title: "Blog"
---

<section id="blog" class="py-5 bg-light">
  <div class="container">

    <!-- Featured Post -->
    {% assign featured = site.posts.first %}
    <div class="row mb-5 align-items-center" style="margin-top: 4rem!important;">
      <div class="col-md-6">
        {% if featured.image %}
          <a href="{{ featured.url }}">
            <img src="{{ featured.image | relative_url }}" alt="{{ featured.title }}" class="img-fluid rounded shadow-sm">
          </a>
        {% endif %}
      </div>
      <div class="col-md-6 d-flex flex-column justify-content-center">
        <h2 class="mb-3">{{ featured.title }}</h2>
        <p class="text-muted">{{ featured.date | date: "%B %d, %Y" }}</p>
        <p>{{ featured.excerpt }}</p>
        <a href="{{ featured.url }}" class="btn btn-primary mt-2">Read More</a>
      </div>
    </div>

    <!-- Remaining Posts -->
    <div class="text-center mb-5" style="margin-top: 3rem!important;">
      <h3 class="text-uppercase font-weight-bold">More Stories</h3>
    </div>

    <div class="row">
      {% for post in site.posts offset:1 %}
        <div class="col-md-6 col-lg-4 mb-4">
          <div class="card h-100 shadow-sm blog-card">
            {% if post.image %}
              <a href="{{ post.url }}">
                <img src="{{ post.image | relative_url }}" class="card-img-top" alt="{{ post.title }}">
              </a>
            {% endif %}
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">
                <a href="{{ post.url }}" class="text-dark">{{ post.title }}</a>
              </h5>
              <p class="card-text">{{ post.excerpt }}</p>
              <a href="{{ post.url }}" class="btn btn-outline-primary btn-sm mt-auto">Read More</a>
            </div>
          </div>
        </div>
      {% endfor %}
    </div>

    <!-- 🔥 Travel Store Section -->
    <div class="text-center mb-4" style="margin-top: 3rem!important;">
      <h3 class="text-uppercase font-weight-bold">Shop Travel Essentials</h3>
    </div>

    <div class="cta-box text-center my-5 p-5 rounded shadow-sm" 
         style="background: linear-gradient(135deg, rgba(255,108,0,0.08), rgba(0,53,128,0.06)); max-width: unset;">

      <h3 class="mb-3 font-weight-bold">Travel Essentials Store</h3>
      <p class="mb-5">Explore our curated Amazon storefront for gear, books, and accessories — handpicked to make your journeys easier and more enjoyable.</p>

      <div class="row">
        {% for product in site.data.products.products limit:4 %}
          <div class="col-md-6 mb-4">
            {% include product-card.html 
              title=product.title 
              image=product.image 
              link=product.link 
              description=product.description %}
          </div>
        {% endfor %}
      </div>

      <div class="text-center mt-4">
        <a href="https://www.amazon.com/shop/voyagebyluna" target="_blank" rel="nofollow noopener sponsored" class="btn btn-lg btn-primary">
          Visit Full Amazon Store →
        </a>
      </div>
    </div>
    <!-- 🔥 End Travel Store Section -->

  </div>
</section>
