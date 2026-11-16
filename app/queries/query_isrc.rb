class QueryIsrc


  protected


  def self.all(musicat_settings, params)
    new(musicat_settings: musicat_settings, params: params).index_admin
  end



  public


  def initialize(**args)
    musicat_settings = args[:musicat_settings]
    params = args[:params] ? args[:params] : {}
    @sorter_admin = determine_sorter_admin(musicat_settings, params)
  end


  def index_admin
    if @sorter_admin
      index_admin_sorted
    else
      index_admin_unsorted
    end
  end


  def index_admin_sorted
    @sorter_admin.sort index_admin_unsorted
  end


  def index_admin_unsorted
    all_isrcable
  end



  private


  def all_isrcable
    result = []
    result << Audio.all.map { |a| a }
    result << Video.all.map { |v| v }
    result.flatten
  end


  def determine_sorter_admin(musicat_settings, params)
    if params[:filter]
      SorterIndexAdminIsrc.find(params[:filter])
    else
      SorterIndexAdminIsrc.find(musicat_settings.admin_index_isrc_sort_method)
    end
  end


end
