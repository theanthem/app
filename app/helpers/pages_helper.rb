module PagesHelper
  def page_children(objects)
      if(objects)
        output = Array.new
        objects.each do |o|
          output << [o.name, o.id]
        end
        output
      end
    end
end
