class QueryPictures


  protected

  def self.find_admin(id)
    Picture.friendly.find(id)
  end

  def self.find_public(id)
    Picture.all_public_showable.friendly.find(id)
  end

  def self.find_admin_with_keyword(keyword)
    Picture.joins(:keywords).where(keywords: {id: keyword.id})
  end

  def self.index_admin(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_admin
  end

  def self.index_admin_by_page(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_admin_by_page
  end

  def self.index_public(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_public
  end

  def self.index_public_by_page(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_public_by_page
  end

  def self.neighborhood_admin(picture, musicat_settings)
    new(musicat_settings: musicat_settings).neighborhood_admin(picture)
  end

  def self.neighborhood_public(picture, musicat_settings)
    new(musicat_settings: musicat_settings).neighborhood_public(picture)
  end

  def self.options_for_select_admin(musicat_settings)
    new(musicat_settings: musicat_settings).options_for_select_admin
  end


  public

  def initialize(**args)
    musicat_settings = args[:musicat_settings]
    params = args[:params] ? args[:params] : {}
    @sorter_admin_index = determine_sorter_admin_index(musicat_settings, params)
    @sorter_admin_form_selectable = determine_sorter_admin_form_selectable(musicat_settings)
    @sorter_public_index = determine_sorter_public_index(musicat_settings, params)
  end

  def index_admin
    @sorter_admin_index ? index_admin_sorted : index_admin_unsorted
  end

  def index_admin_by_page
    Picture.paginate(collection: index_admin, limit: @params[:limit], page: @params[:page])
  end

  def index_admin_sorted
    @sorter_admin_index.sort(index_admin_unsorted)
  end

  def index_admin_unsorted
    Picture.all.include_everything
  end

  def index_public
    @sorter_public_index ? index_public_sorted : index_public_unsorted
  end

  def index_public_by_page
    Picture.paginate(collection: index_public, limit: @params[:limit], page: @params[:page])
  end

  def index_public_sorted
    @sorter_public_index.sort(index_public_unsorted)
  end

  def index_public_unsorted
    Picture.all_public_indexable.include_everything
  end

  def neighborhood_admin(picture, distance: 1)
    Picture.neighborhood(picture, collection: index_admin, distance: distance)
  end

  def neighborhood_public(picture, distance: 1)
    Picture.neighborhood(picture, collection: index_public, distance: distance)
  end

  def options_for_select_admin
    @sorter_admin_form_selectable ? options_for_select_admin_sorted : options_for_select_admin_unsorted
  end

  def options_for_select_admin_sorted
    @sorter_admin_form_selectable.sort(options_for_select_admin_unsorted)
  end

  def options_for_select_admin_unsorted
    Picture.with_attached_source_uploaded.select(:id, :source_imported_file_path, :source_type, :title_without_markup)
  end


  private

  def determine_sorter_admin_index(musicat_settings, params)
    if params[:filter]
      SorterIndexAdminPictures.find(params[:filter])
    else
      SorterIndexAdminPictures.find(musicat_settings.admin_index_pictures_sort_method)
    end
  end

  def determine_sorter_admin_form_selectable(musicat_settings)
    SorterFormSelectablePictures.find(musicat_settings.admin_forms_selectable_pictures_sort_method)
  end

  def determine_sorter_public_index(musicat_settings, params)
    if params[:filter]
      SorterIndexPublicPictures.find(params[:filter])
    else
      SorterIndexPublicPictures.find(musicat_settings.public_index_pictures_sort_method)
    end
  end

end
