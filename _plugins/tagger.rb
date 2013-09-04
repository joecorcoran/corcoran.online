module Jekyll
  class Tagger < Generator

    def generate(site)
      @site = site
      generate_tag_pages!
    end

    private

      def generate_tag_pages!
        @site.tags.each do |tag, posts|
          add_tag!(tag, posts)
        end
      end

      def add_tag!(tag, posts)
        if layout = @site.config["tag_layout"]
          data = {
            'layout' => layout,
            'posts'  => posts.sort.reverse!,
            'tag'    => tag
          }
          @site.pages << TagPage.new(@site, @site.source, "#{@site.config["tag_directory"]}/#{tag.gsub(/\s+/, '+')}", 'index.html', data)
        end
      end

  end

  class TagPage < Page

    def initialize(site, base, dir, name, data = {})
      self.content = data.delete('content') || ''
      self.data    = data
      super(site, base, dir[-1, 1] == '/' ? dir : '/' + dir, name)
    end

    def read_yaml(*)
      # noop
    end

  end
end
