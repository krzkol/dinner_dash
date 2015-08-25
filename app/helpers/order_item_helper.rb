module OrderItemHelper
  def add_to_cart(item)
    link_to order_items_path(item_id: item.id), method: :post, remote: true do
      (content_tag(:span, "", class: "glyphicon glyphicon-plus") + " Add to cart").html_safe
    end
  end
end
