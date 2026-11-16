class QueryEvents


  protected

  def self.find_admin(id)
    Event.friendly.find(id)
  end

  def self.find_public(id)
    Event.all_public_showable.friendly.find(id)
  end

  def self.index_admin(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_admin
  end

  def self.index_public(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_public
  end

  def self.neighborhood_admin(event, musicat_settings)
    new(musicat_settings: musicat_settings).neighborhood_admin(event)
  end

  def self.neighborhood_public(event, musicat_settings)
    new(musicat_settings: musicat_settings).neighborhood_public(event)
  end

  def self.options_for_select_admin
    Event.select(:id, :datetime_utc, :datetime_zone, :title_without_markup).sort_by{ |e| e.datetime_utc }
  end


  public

  def initialize(**args)
    musicat_settings = args[:musicat_settings]
    params = args[:params] ? args[:params] : {}
    @sorter_admin = determine_sorter_admin(musicat_settings, params)
    @sorter_public = determine_sorter_public(musicat_settings, params)
  end

  def index_admin
    @sorter_admin ? index_admin_sorted : index_admin_unsorted
  end

  def index_admin_sorted
    @sorter_admin.sort index_admin_unsorted
  end

  def index_admin_unsorted
    Event.all.include_everything
  end

  def index_public
    @sorter_public ? index_public_sorted : index_public_unsorted
  end

  def index_public_sorted
    @sorter_public.sort index_public_unsorted
  end

  def index_public_unsorted
    Event.all_public_indexable.include_everything
  end

  def neighborhood_admin(event, distance: 1)
    Event.neighborhood(event, collection: index_admin, distance: distance)
  end

  def neighborhood_public(event, distance: 1)
    Event.neighborhood(event, collection: index_public, distance: distance)
  end


  private

  def determine_sorter_admin(musicat_settings, params)
    if params[:filter]
      SorterIndexAdminEvents.find(params[:filter])
    else
      SorterIndexAdminEvents.find(musicat_settings.admin_index_events_sort_method)
    end
  end

  def determine_sorter_public(musicat_settings, params)
    if params[:filter]
      SorterIndexPublicEvents.find(params[:filter])
    else
      SorterIndexPublicEvents.find(musicat_settings.public_index_events_sort_method)
    end
  end


end
