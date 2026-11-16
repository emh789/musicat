class Public::AlbumsController < PublicController


  def index
    @albums = QueryAlbums.index_public(@musicat_settings, params)
  end


  def show
    @album = QueryAlbums.find_public(params[:id])
    @album_neighbors = QueryAlbums.neighborhood_public(@album, @musicat_settings)
  end


end
