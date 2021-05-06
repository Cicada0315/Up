module PostsHelper
    def fields_for_helper(f)
        if @category
            f.hidden_field :category_id, value: @category.id 
        else 
            render partial: "fields_for", locals: {f: f}  
        end 
    end
end
