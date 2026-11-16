class Public::EventsController < PublicController


  def index
    events = QueryEvents.index_public(@musicat_settings, params)
    if events.empty?
      render :index_nil
    else
      case events
      when ActiveRecord::Relation
        @events = events
        render :index_array
      when Array
        @events = events
        render :index_array
      when Hash
        @events_calendar = events
        render :index_hash
      else
        render :index_nil
      end
    end
  end


  def show
    @event = QueryEvents.find_public(params[:id])
    @event_neighbors = QueryEvents.neighborhood_public(@event, @musicat_settings)
  end



  # def index_collection_render(events)
  #   if events.empty?
  #     render :index_nil
  #   else
  #     case events
  #     when ActiveRecord::Relation
  #       @events = events
  #       render :index_array
  #     when Array
  #       @events = events
  #       render :index_array
  #     when Hash
  #       @events_calendar = events
  #       render :index_hash
  #     else
  #       render :index_nil
  #     end
  #   end
  # end



end
