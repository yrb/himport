module ApplicationHelper
  def sidebar_item(path, &block)
    selected = current_page?(path)
    content_tag(:li) do
      link_to path, class: class_names(
        "group flex gap-x-3 rounded-md p-2 text-sm font-semibold leading-6",
        {
          "sidebar-item-default": !selected,
          "sidebar-item-current": selected
        }
      ) do
        block.call(selected)
      end
    end
  end
end
