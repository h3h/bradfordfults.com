module Jekyll
  class SubcategoryLinkTag < Liquid::Tag

    def initialize(tag_name, url, tokens)
      super
      @url = url
    end

    def render(context)
      # TODO: use @url or @path or whatever
    end
  end
end

Liquid::Template.register_tag('subcategory_link', Jekyll::SubcategoryLinkTag)
