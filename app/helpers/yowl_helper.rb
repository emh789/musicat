module YowlHelper


  def yowl_amplitude_init(audio_array)
<<-AMPLITUDE_INIT
<script>
  Amplitude.init({songs: #{yowl_amplitude_songs(audio_array)}});
</script>
AMPLITUDE_INIT
  end


  def yowl_amplitude_init_single(audio)
<<-AMPLITUDE_INIT
<script>
  Amplitude.init({songs: #{yowl_amplitude_single(audio)}});
</script>
AMPLITUDE_INIT
  end


  def yowl_amplitude_single(audio)
    [{ name: audio.title, url: audio_preferred_url(audio) }].to_json
  end


  def yowl_amplitude_songs(audio_array)
    audio_array.map {|aa| yowl_amplitude_song(aa.audio)}.to_json
  end


  def yowl_amplitude_song(audio)
    { name: audio.title, url: audio_preferred_url(audio) }
  end


  def yowl_amplitude_progress_bar
<<-AMPLITUDE_PROGRESS
<script>
document.getElementById('yowl_progress').addEventListener('click', function( e ){
    var offset = this.getBoundingClientRect();
    var x = e.pageX - offset.left;

    Amplitude.setSongPlayedPercentage( ( parseFloat( x ) / parseFloat( this.offsetWidth) ) * 100 );
});
</script>
AMPLITUDE_PROGRESS
  end

end
