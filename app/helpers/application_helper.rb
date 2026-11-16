module ApplicationHelper


  def artist_copyright_summary(musicat_settings)
    "© #{artist_copyright_year_range(musicat_settings)} except where indicated"
  end


  def artist_copyright_year_range(musicat_settings)
    current_year = Time.zone.now.year.to_s
    given_year = @musicat_settings.artist_content_copyright_year_earliest.to_s
    if given_year == ''
      "#{current_year}"
    elsif given_year == current_year
      "#{given_year}"
    elsif given_year.to_i < current_year.to_i
      "#{given_year}–#{current_year}"
    else
      "#{current_year}"
    end
  end


  def app_script_element_for(js)
    case Rails.env
    when 'production'
      assembled_script = String.new
      js.each_line { |l| assembled_script << l.strip }
    when 'development'
      assembled_script = js
    else
      assembled_script = js
    end
    tag.script(sanitize(assembled_script))
  end


end
