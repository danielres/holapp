module News

  class Digest

    def initialize(collection)
      @collection = collection
    end

    def call
      @collection.map do |i|
        output = ""
        output << "<h2>#{ MarkdownRenderer.new.call(i.summary.to_s) }</h2>"
        output << MarkdownRenderer.new.call(i.body.to_s)
        output
      end.join("\n\n<hr />\n\n").html_safe
    end

  end
end
