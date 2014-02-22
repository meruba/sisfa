window.NestedFormEvents::insertFields = (content, assoc, link) ->
  $tr = undefined
  $tr = $(link).closest("tr")
  if $tr.size() > 0
    $(content).insertBefore $tr
  else
    target = $(link).data("target")
    if target
      $(content).appendTo $(target)
    else
      $(content).insertBefore link