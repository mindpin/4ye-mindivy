bind_events = (mindmap)->
  return if not mindmap?

  window.mindmap = mindmap

  # 设置工具按钮操作事件
  # 导图居中显示
  jQuery('.mindmap-ops a.op.center').on 'click', =>
    mindmap.center_to_root()

  jQuery('.mindmap-ops a.op.zoom-out').on 'click', =>
    mindmap.zoom_out()
    jQuery('.mindmap-ops .scale span.value').html mindmap.scale

  jQuery('.mindmap-ops a.op.zoom-in').on 'click', =>
    mindmap.zoom_in()
    jQuery('.mindmap-ops .scale span.value').html mindmap.scale


  # 保存新档
  jQuery('.mindmap-ops a.op.save').on 'click', =>
    $form = jQuery('form')
    $form.find('textarea').val mindmap.to_json()
    $form.attr 'action', '/'
    $form.find('input[name=_method]').val 'post'
    $form.submit()

  # 保存版本
  jQuery('.mindmap-ops a.op.update').on 'click', =>
    $form = jQuery('form')
    $form.find('textarea').val mindmap.to_json()
    $form.submit()


jQuery(document).on 'ready page:load', ->
  if jQuery('.new-mindmap').length
    # # 从本地缓存读入
    # if json = localStorage['mindmap']
    #   mindmap = Mindmap.from_json json
    #   mindmap.layout()

    # # 新建
    # else
    mindmap = new Mindmap jQuery('.mindmap')
    mindmap.init()
    mindmap.layout()

  else
    # 从表单读入
    json = jQuery('textarea[name=content]').val()
    mindmap = Mindmap.from_json json
    mindmap.layout()

  bind_events mindmap

jQuery(window).on 'beforeunload', ->