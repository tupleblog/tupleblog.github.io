module Jekyll
  class BokehAltImg < Liquid::Tag

    def initialize(tag_name, img_link, tokens)
      super
      @img_link = img_link
    end

    def render(context)
      "<figure class=\"hidepc\">
        <center>
          <img width=\"auto\" src=\"#{@img_link}\" data-action=\"zoom\"/>
        </center>
      </figure>"
    end
  end
end

Liquid::Template.register_tag('bokeh_alt_img', Jekyll::BokehAltImg)