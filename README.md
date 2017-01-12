# Simple Ruby on Rails web tag scraper

## Description
<p>The scraper provides an input box where you can provide a URL. The web scraper will return the list of tags from the given URL response. This implementation relies on the <a href="http://www.nokogiri.org/">Nokogiri</a> library for parsing the HTML content, so the order of the tags is based on the Nokogiri's parser behavior, which seems to be POST-ORDER at glance (Haven't looked into its <a href="https://github.com/sparklemotion/nokogiri">implementation</a>, but you are welcome to do so).</p>

## Content

<div align="center"><strong>The files that contain the juice of the app are (in order of importance):</strong></div>

<ol>
  <li>app/controller/url_tag_lists_controller.rb</li>
  <li>app/views/url_tag_lists/search.html.erb</li>
  <li>config/routes.rb</li>
</ol>

## License

This project is licensed under the MIT license, Copyright (c) 2017 Carlos Castro.
