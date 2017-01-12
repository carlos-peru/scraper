# Simple Ruby on Rails web tag scraper

## Description
<p>The scraper provides an input box where you can provide a URL. The web scraper will return the list of tags from the given URL response. This implementation relies on the <a href="http://www.nokogiri.org/">Nokogiri</a> library for parsing the HTML content, so the order of the tags is based on the Nokogiri's parser behavior, which seems to be POST-ORDER at glance (Haven't looked into its <a href="https://github.com/sparklemotion/nokogiri">implementation</a>, but you are welcome to do so).</p>

## Content

<div>The files that contain the juice of the app are (in order of relevance):</div><br>

<ol>
  <li>app/controller/url_tag_lists_controller.rb</li>
  <li>app/views/url_tag_lists/search.html.erb</li>
  <li>config/routes.rb</li>
  <li>db/migrate/20170111230240_create_url_tag_lists.rb</li>
</ol>

## Demo
<a href="https://rails-html-tags-scraper.herokuapp.com/">https://rails-html-tags-scraper.herokuapp.com/</a>

## License

This project is licensed under the MIT license, Copyright (c) 2017 Carlos Castro.
