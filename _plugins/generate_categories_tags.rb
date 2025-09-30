{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 Jekyll::Hooks.register :site, :post_read do |site|\
  # Generate category pages\
  site.categories.each do |category, posts|\
    site.pages << Jekyll::PageWithoutAFile.new(site, site.source, "category/#\{category.downcase\}", "index.html").tap do |page|\
      page.data["layout"] = "category"\
      page.data["title"] = category.capitalize\
      page.data["slug"] = category.downcase\
    end\
  end\
\
  # Generate tag pages\
  site.tags.each do |tag, posts|\
    site.pages << Jekyll::PageWithoutAFile.new(site, site.source, "tag/#\{tag.downcase\}", "index.html").tap do |page|\
      page.data["layout"] = "tag"\
      page.data["title"] = tag.capitalize\
      page.data["slug"] = tag.downcase\
    end\
  end\
end}