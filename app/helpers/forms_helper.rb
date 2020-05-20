module FormsHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    content_tag(:a, nil, { href: 'javascript:void(0);', class: 'add_fields btn btn-primary mt-3', data: { id: id, fields: fields.gsub("\n", "") } }) do
      name.html_safe +
      content_tag(:i, nil, { class: 'fas fa-plus ml-2' })
    end
  end
end
