# frozen_string_literal: true

# The site's navigation: one list, drawn in the footer as nav#nav, which the
# template's script copies into the header tabs and the menu. The layout
# draws it on every page. The current item comes from the page's address;
# a view can name it instead with nav(active: 'key'). Items the signed-in
# user can't open are left out.
module Application::NavigationHelper
  NavItem = Data.define(:label, :url, :key, :secondary, :children)

  # Names the current item when the address alone can't, such as a page
  # under one section's address that belongs to another
  def nav(active: nil)
    content_for(:nav_active, active.to_s, flush: true)
  end

  # The items this user can open, with their sub-lists
  def nav_items
    visible_nav_items(nav_tree)
  end

  # The current item's key: the one a view named, or the deepest item whose
  # address holds this page's
  def nav_current(items = nav_items)
    key = content_for(:nav_active).presence
    named = key && nav_flatten(items).find { |item| item.key == key }
    (named || nav_match(items))&.key
  end

  private

  # A hidden section's pages the user may open move up to its level, so
  # hiding People doesn't hide Shifts from someone allowed to see them
  def visible_nav_items(items)
    items.flat_map do |item|
      children = visible_nav_items(item.fetch(:children, []))
      next children unless can?(item[:can].first, item[:can].last)

      [
        NavItem.new(
          label: item[:label],
          url: item[:url],
          key: item[:key],
          secondary: item.fetch(:secondary, false),
          children: children
        )
      ]
    end
  end

  def nav_match(items)
    path = request.path
    nav_flatten(items)
      .select { |item| nav_holds?(item.url, path) }
      .max_by { |item| item.url.length }
  end

  def nav_flatten(items)
    items.flat_map { |item| [item, *nav_flatten(item.children)] }
  end

  # /tools holds /tools and /tools/5, but not /toolsets
  def nav_holds?(url, path)
    path == url || path.start_with?("#{url.chomp('/')}/")
  end
end
