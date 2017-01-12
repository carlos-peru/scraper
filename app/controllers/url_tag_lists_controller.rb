class UrlTagListsController < ApplicationController

  # GET /
  def search
    if !params[:url].blank?
      # Remove leading and trailing white spaces
      @url = params[:url].strip
      # Append http protocol if needed
      @url = "http://#{@url}" if !@url.include? "://"

      if is_url_valid(@url)

        # Check in the database if url has been processed already
        @url_tag_list = UrlTagList.where(url: @url).take
        # This is arbitrary, so 1.minute.ago, 10.seconds.ago or any other timeframe could have been used
        cache_timeout = 1.week.ago
        # NOTE: Remember that the smaller the value of the time, the older it is.
        if @url_tag_list.nil? || @url_tag_list.updated_at < cache_timeout
          # If result is older than a week, then we do a new request
          uri = URI(@url)
          begin
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
            cache_processed_url(@url, tag_list[2..-1])
          rescue SocketError => error
            logger.error "Failed to connect to the given url: #{error}"
          end
        end
      end
    end
  end

  private
    def is_url_valid(url)
      !(@url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix).nil?
    end

    def cache_processed_url(url, tags)
      # If it exists update
      if @url_tag_list
        @url_tag_list.update(url: url, tags: tags)
      else
        @url_tag_list = UrlTagList.create(url: url, tags: tags)
      end
    end
end
