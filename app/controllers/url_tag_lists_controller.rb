class UrlTagListsController < ApplicationController

  # GET /
  def search
    if params[:url] && !params[:url].empty?
      # Remove leading and trailing white spaces
      url = params[:url].strip
      # Append http protocol if needed
      url = "http://#{url}" if !url.include? "://"

      # Check if url has been processed already
      @url_tag_list = UrlTagList.where(url: url).take
      # If result is older than a week, then we do a new search
      # This is arbitrary, so 1.minute.ago or 10.seconds.ago could have been used
      cache_timeout = 10.seconds.ago
      # NOTE: Remember that the smaller the value of the time, the older it is.
      if @url_tag_list.nil? || @url_tag_list.updated_at < cache_timeout
        uri = URI(url)
        response = Net::HTTP.get(uri)
        html = Nokogiri::HTML(response)
        # Create empty tag list string
        tag_list = ""
        # This is equivalent to traversing the nodes recursively
        # For more information: http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Node#traverse-instance_method
        html.traverse do |node|
          if Nokogiri::XML::Element == node.class
            # Append tag
            tag_list << ", " << node.name
          end
        end
        # Remove leading comma (,) from tags
        cache_processed_url(url, tag_list[2..-1])
      end
    end
  end

  private

    def cache_processed_url(url, tags)
      # If it exists update
      if @url_tag_list
        @url_tag_list.update(url: url, tags: tags)
      else
        @url_tag_list = UrlTagList.create(url: url, tags: tags)
      end
    end
end
