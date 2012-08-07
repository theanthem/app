module ApplicationHelper
  
  def more_split(content)
    split = content.split("[---MORE---]")
    split.first
  end

  def remove_more_tag(content)
    content.sub("[---MORE---]", '')
  end
  
  def status_tag(boolean, options={})
    options[:true]        ||= ''
    options[:true_class]  ||= 'status true'
    options[:false]       ||= ''
    options[:false_class] ||= 'status false'

    if boolean
      content_tag(:span, options[:true], :class => options[:true_class])
    else
      content_tag(:span, options[:false], :class => options[:false_class])
    end
  end
  
  def error_messages_for( object )
    render(:partial => 'shared/error_messages', :locals => {:object => object})
  end

end
