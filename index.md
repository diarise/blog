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
    
<!-- test tags and categories -->
<section class="browse-topics container">
  <h2>Browse Topics</h2>
  <p>Find inspiration by exploring our most popular categories and tags.</p>

  <div class="topics-buttons">
    <a href="/categories/" class="btn-topic">Explore Categories</a>
    <a href="/tags/" class="btn-topic alt">Discover Tags</a>
  </div>
</section>

<style>
.browse-topics {
  text-align: center;
  padding: 3rem 1rem;
  background: #fafafa;
  border-radius: 12px;
  margin: 3rem auto;
  max-width: 900px;
  box-shadow: 0 3px 10px rgba(0,0,0,0.05);
}
.browse-topics h2 {
  font-size: 2rem;
  color: #222;
  margin-bottom: .5rem;
}
.browse-topics p {
  color: #666;
  margin-bottom: 2rem;
}
.topics-buttons {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}
.btn-topic {
  background: #06d6a0;
  color: white;
  padding: .8rem 1.8rem;
  border-radius: 30px;
  text-decoration: none;
  font-weight: 600;
  transition: .3s;
}
.btn-topic:hover {
  background: #118ab2;
  transform: translateY(-2px);
}
.btn-topic.alt {
  background: #ffd166;
  color: #333;
}
.btn-topic.alt:hover {
  background: #ef476f;
  color: #fff;
}
</style>
<!-- end test tags and categories -->
    

    <!-- Remaining Posts -->
    <div class="text-center mb-5" style="margin-top: 3rem!important;">
      <h2 class="mb-4 font-weight-bold">Explore More</h2>
  <p class="text-muted mb-4">Browse all our stories by category or tag and discover new destinations.</p>
  <div class="btn-group">
    <a href="{{ '/categories/' | relative_url }}" class="btn btn-outline-primary btn-lg">
      <i class="fas fa-folder-open mr-2"></i> Categories
    </a>
    <a href="{{ '/tags/' | relative_url }}" class="btn btn-outline-secondary btn-lg">
      <i class="fas fa-tags mr-2"></i> Tags
    </a>
  </div>
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
