module NavPublicHelper

  def nav_public_select(musicat_settings, **args)
    if musicat_settings.public_layout_will_have_nav
      if params[:controller] == 'public/infopages'
        content_tag(:select, nav_public_select_options_indexes(musicat_settings), id: args[:id], class: args[:class]).html_safe
      else
        case params[:action]
        when 'index'
          content_tag(:select, nav_public_select_options_indexes(musicat_settings), id: args[:id], class: args[:class]).html_safe
        when 'show'
          if content_for(:page_subtitle)
            content_tag(:select, nav_public_select_optgroups(musicat_settings), id: args[:id], class: args[:class]).html_safe
          else
            content_tag(:select, nav_public_select_options_indexes(musicat_settings), id: args[:id], class: args[:class]).html_safe
          end
        else
          content_tag(:select, nav_public_select_options_indexes(musicat_settings), id: args[:id], class: args[:class]).html_safe
        end
      end
    end
  end

  def nav_public_select_optgroups(musicat_settings)
    [ content_tag(:optgroup, nav_public_select_optgroup_option_current, label: content_for(:page_subtitle).concat(':')),
      content_tag(:optgroup, nav_public_select_optgroup_options_indexes(musicat_settings), label: '─────────')
    ].join("\n").html_safe
  end

  def nav_public_select_optgroup_option_current
    content_tag(:option, content_for(:page_subtitle_detail), selected: 'selected')
  end

  def nav_public_select_optgroup_options_indexes(musicat_settings)
    nav_public_indexes(musicat_settings).map { |o| nav_public_select_option_tag(o, selectable: false) }.join("\n").html_safe
  end

  def nav_public_select_options_indexes(musicat_settings)
    nav_public_indexes(musicat_settings).map { |o| nav_public_select_option_tag(o, selectable: true) }.join("\n").html_safe
  end

  def nav_public_select_option_tag(option = { label: '', controller: '', path: '' }, selectable: nil)
    if (selectable) && (option[:controller].match(params[:controller]))
      content_tag(:option, option[:label], selected: 'selected', data: {url: option[:path]})
    else
      content_tag(:option, option[:label], data: {url: option[:path]})
    end
  end


  private

  def nav_public_indexes(musicat_settings)
    [
      nav_public_index_albums(musicat_settings),
      nav_public_index_events(musicat_settings),
      nav_public_index_info(musicat_settings),
      nav_public_index_pictures(musicat_settings),
      nav_public_index_videos(musicat_settings)
    ].reject { |a| a == nil }
  end

  def nav_public_index_albums(musicat_settings)
    if musicat_settings.public_nav_can_include_albums
      { label: 'Albums', controller: 'public/albums', path: public_albums_path }
    end
  end

  def nav_public_index_events(musicat_settings)
    if musicat_settings.public_nav_can_include_events
      { label: 'Events', controller: 'public/events', path: public_events_path }
    end
  end

  def nav_public_index_info(musicat_settings)
    if musicat_settings.public_nav_can_include_info
      { label: 'Info', controller: 'public/infopages', path: public_infopage_first_path }
    end
  end

  def nav_public_index_pictures(musicat_settings)
    if musicat_settings.public_nav_can_include_pictures
      { label: 'Pictures', controller: 'public/pictures', path: public_pictures_path }
    end
  end

  def nav_public_index_videos(musicat_settings)
    if musicat_settings.public_nav_can_include_videos
      { label: 'Videos', controller: 'public/videos', path: public_videos_path }
    end
  end

end
