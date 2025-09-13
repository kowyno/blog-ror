module ArticlesHelper
  include Pagy::Frontend

  def pagy_nav_tailwind(pagy)
    html = +'<nav class="flex justify-center my-4"><ul class="inline-flex -space-x-px">'

    if pagy.prev
      html << %(<li><a href="#{pagy_url_for(pagy, pagy.prev)}" class="px-3 py-2 border border-gray-300 text-gray-700 hover:bg-gray-200">&laquo;</a></li>)
    else
      html << %(<li><span class="px-3 py-2 border border-gray-300 text-gray-400 bg-gray-100">&laquo;</span></li>)
    end

    html << pagy.series.map do |item|
      case item
      when Integer
        %(<li><a href="#{pagy_url_for(pagy, item)}" class="px-3 py-2 border border-gray-300 text-gray-700 hover:bg-gray-200">#{item}</a></li>)
      when String
        %(<li><span class="px-3 py-2 border border-gray-300 bg-gray-100 text-gray-500">#{item}</span></li>)
      when :prev
        %(<li><a href="#{pagy_url_for(pagy, pagy.prev)}" class="px-3 py-2 border border-gray-300 text-gray-700 hover:bg-gray-200">&lt;</a></li>)
      when :next
        %(<li><a href="#{pagy_url_for(pagy, pagy.next)}" class="px-3 py-2 border border-gray-300 text-gray-700 hover:bg-gray-200">&gt;</a></li>)
      end
    end.join

    if pagy.next
      html << %(<li><a href="#{pagy_url_for(pagy, pagy.next)}" class="px-3 py-2 border border-gray-300 text-gray-700 hover:bg-gray-200">&raquo;</a></li>)
    else
      html << %(<li><span class="px-3 py-2 border border-gray-300 text-gray-400 bg-gray-100">&raquo;</span></li>)
    end

    html << '</ul></nav>'
    html.html_safe
  end

  def publication_state_badge(article)
    case article.publication_state
    when "published"
      content_tag :span, "Publicado", class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 w-fit"
    when "draft"
      content_tag :span, "Borrador", class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800 w-fit"
    else
      content_tag :span, "Desconocido", class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800 w-fit"
    end
  end
end