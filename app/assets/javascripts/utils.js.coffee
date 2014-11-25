root = exports ? this

root.onURLBlocked = (base_url, error_callback, success_callback) ->
  success_callback ||= ->
  $("<img width=0 height=0>")
  .error(error_callback)
  .on('load',success_callback)
  .attr("src", base_url + "?" + Math.random())
  .css("position", "absolute")
  .appendTo("body")
