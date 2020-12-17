$(document).on('turbolinks:load', function () {
  $(".advanced-search-facet-select").chosen({
    placeholder_text_multiple: "Select...",
    single_backstroke_delete: false,
    inherit_select_classes: true
  });
})
