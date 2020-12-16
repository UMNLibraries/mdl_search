$(document).on('turbolinks:load', function () {
  $(".advanced-search-facet-select").select2({
    placeholder: "Select...",
    theme: "bootstrap"
  });
})
