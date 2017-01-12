Rails.application.routes.draw do
  root to: "url_tag_lists#search"
  get 'search', :to => 'url_tag_lists#search'
end
