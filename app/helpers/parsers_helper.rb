module ParsersHelper

  def parser_div(resource_text_props)
    parser_result(resource_text_props, wrap_with: :div)
  end

  def parser_inline(resource_text_props)
    sanitize parser_result(resource_text_props), tags: ['a', 'b', 'em', 'i', 'strong']
  end

  def parser_remove_markup(resource_text_props)
    strip_tags(parser_result(resource_text_props))
  end

  def parser_result(resource_text_props, html_class: nil, wrap_with: nil)
    result = MarkupParser.parse_sanitize(resource_text_props)
    case wrap_with
    when :div
      content_tag(wrap_with, result, class: :mc_parser)
    when nil
      result
    end
  end

  def parser_vendor_links(markdown)
    fragment = Commonmarker.to_html(markdown)
    fragment_tree = Nokogiri::HTML5.fragment(fragment)
    fragment_tree.css('ul').each { |node| node['class'] = 'yowl_vendor_links' }
    fragment_tree.css('li').each { |node| node['class'] = 'yowl_vendor_link' }
    fragment_tree.to_html.html_safe
  end

end
