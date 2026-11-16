class Admin::MusicatSettingsController < AdminController


  def edit
    @musicat_settings = QueryMusicatSettings.get
    @form_metadata = FormMusicatSettingsMetadata.new(pane: params[:pane])
  end


  def purge_icon_image
    @musicat_settings = QueryMusicatSettings.get
    @musicat_settings.icon_image.purge
    flash[:notice] = 'Icon image purged.'
    redirect_to edit_admin_musicat_settings_path(@musicat_settings, pane: :icon)
  end


  def update
    @musicat_settings = QueryMusicatSettings.get
    @musicat_settings.assign_attributes(params_musicat_settings_permitted)
    changed = @musicat_settings.changed
    @form_metadata = FormMusicatSettingsMetadata.new(pane: params[:pane])
    if @musicat_settings.save
      flash[:notice] = 'MusiCat settings were successfully updated.'
      flash[:changed] = changed
      redirect_to edit_admin_musicat_settings_path
    else
      flash[:notice] = 'MusiCat settings could not be updated.'
      flash[:errors] = @musicat_settings.errors.attribute_names
      render 'edit'
    end
  end


  def update_from_resource_and_return
    @musicat_settings = QueryMusicatSettings.get
    if @musicat_settings.update(params_musicat_settings_permitted)
      flash[:notice] = 'MusiCat settings were successfully updated.'
      params.delete('filter')
      redirect_to request.referrer
    else
      @form_metadata = FormMusicatSettingsMetadata.new(pane: params[:pane])
      flash[:notice] = 'MusiCat settings could not be updated.'
      render 'edit'
    end
  end



  private


  def params_musicat_settings_permitted
    params.require(:musicat_settings).permit(
      :admin_forms_autokeyword_enabled,
      :admin_forms_autokeyword_id,
      :admin_forms_edit_slug_field,
      :admin_forms_retain_pane_for_neighbors,
      :admin_forms_selectable_pictures_sort_method,
      :admin_index_albums_sort_method,
      :admin_index_audio_sort_method,
      :admin_index_events_sort_method,
      :admin_index_isrc_sort_method,
      :admin_index_pictures_sort_method,
      :admin_index_videos_sort_method,
      :artist_content_copyright_year_earliest,
      :artist_content_copyright_year_latest,
      :artist_name,
      :audio_default_isrc_country_code,
      :audio_default_isrc_registrant_code,
      :audio_default_date_released_enabled,
      :audio_default_date_released,
      :marquee_enabled,
      :marquee_markup_type,
      :marquee_markup_text,
      :html_head_public_can_include_meta_description,
      :icon_image,
      :icon_source_imported_file_path,
      :icon_source_type,
      :public_homepage_target,
      :public_index_albums_sort_method,
      :public_index_audio_sort_method,
      :public_index_events_sort_method,
      :public_index_pictures_sort_method,
      :public_index_videos_sort_method,
      :public_nav_can_include_albums,
      :public_nav_can_include_audio,
      :public_nav_can_include_events,
      :public_nav_can_include_info,
      :public_nav_can_include_pictures,
      :public_nav_can_include_stream,
      :public_nav_can_include_videos
     )
   end


end
