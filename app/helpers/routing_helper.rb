module RoutingHelper

  def routing_action_is_new_or_create(action)
    (action =~ /\Anew/i) || (action =~ /\Acreate/i)
  end

  def routing_will_have_autokeyword(action, resource)
    routing_action_is_new_or_create && resource.does_have_autokeyword
  end

  def routing_will_retain_edit_pane(musicat_settings, pane)
    (musicat_settings) && (musicat_settings.admin_forms_retain_pane_for_neighbors == true) && (pane)
  end

end
