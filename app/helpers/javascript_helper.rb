module JavascriptHelper


  ###########


  def js_function_album_picture_cycler(picture_filepath_string)
<<-JS_FUNCTION_ALBUM_PICTURE_CYCLER

Musicat.current_pictureCycler = {
  _onReady: function() {
    $(document).on('click', '.mc_active_picture_viewer', function(event) { Musicat.current_pictureCycler.cyclePictures(event, Musicat.current_pictureCycler.pictures) });
  },
  cyclePictures: function(event, pictures) {
    var oldImageSrc = pictures.shift();
    var newImageSrc = pictures[0];
    $(event.target).attr('src', newImageSrc);
    pictures.push(oldImageSrc);
  },
  pictures: [ #{picture_filepath_string} ],
};

$(document).on('ready', Musicat.current_pictureCycler._onReady);

JS_FUNCTION_ALBUM_PICTURE_CYCLER
  end


  ###########

end
