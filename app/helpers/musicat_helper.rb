module MusicatHelper

  def musicat_admin_header_nav_actions
    ['new', 'import', 'upload', 'index', 'public']
  end

  def musicat_admin_header_nav_buttons
    result = ''
    html_class = [:mc_admin_header_nav_button, :color_bg3, :color_fg, :faux_border]
    musicat_admin_header_nav_actions.each do |b|
      case b
      when 'import'
        result << button_tag(icon_new_import, class: html_class)
      when 'index'
        result << button_tag(icon_index, class: html_class)
      when 'new'
        result << button_tag(icon_new, class: html_class)
      when 'public'
        result << button_tag(icon_public, class: html_class)
      when 'upload'
        result << button_tag(icon_new_upload, class: html_class)
      end
    end
    result.html_safe
  end

  def musicat_logo(html_class: nil)
    img = tag.img(src: asset_url("#{Rails.application.config.x.musicat[:app_logo_file_path]}"), class: :musicat_logo_inner)
    tag.div img, class: [html_class, :musicat_logo_outer]
  end

  def musicat_favicon_filepath
    url_for Rails.application.config.x.musicat[:app_logo_icon_file_path]
  end

  def musicat_settings_admin_edit_nav_button(musicat_settings: nil, category: nil, current_pane: nil)
    button_admin_to_edit_pane(
      current_pane: current_pane,
      target_link: edit_admin_musicat_settings_path(musicat_settings, pane: category),
      target_pane: category
    )
  end

end
