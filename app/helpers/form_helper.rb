module FormHelper

  def form_message_picture_datetime_cascade
    'The <em>datetime cascade</em> option will order pictures based on the first available data, choosing from 1) a manually-entered date/time, 2) the date/time from image metadata, 3) the date/time from the picture file.'.html_safe
  end

  def form_SlimSelect_options(collection, text_method)
    placeholder_option = options_for_select([['Choose…', '', {'data-placeholder' => 'true'} ]])
    collection_options = options_from_collection_for_select(collection, :id, text_method)
    placeholder_option.concat(collection_options)
  end

  def form_SlimSelect_picture_options(pictures)
    placeholder_option = options_for_select([['Choose…', '', {'data-placeholder' => 'true'} ]])
    picture_options = options_for_select(pictures.map { |picture|
      [
        picture.title_for_display,
        picture.id,
        {'data-picture-src' => picture_preferred_url(picture)}
      ]
    })
    placeholder_option.concat(picture_options)
  end


  def form_will_include_autokeyword(action, resource)
    routing_action_is_new_or_create(action) && resource.is_newly_built_and_has_unassigned_keyword
  end

end
