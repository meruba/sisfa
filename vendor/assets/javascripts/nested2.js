$(function() {
  var fieldsCount,
      maxFieldsCount = 8,
      $addLink = $('a.add_nested_fields');

  function toggleAddLink() {
    $addLink.toggle(fieldsCount <= maxFieldsCount)
  }

  $(document).on('nested:fieldAdded:item_facturas', function() {
    fieldsCount += 1;
    toggleAddLink();
  });

  $(document).on('nested:fieldRemoved:item_facturas', function() {
    fieldsCount -= 1;
    toggleAddLink();
  });  

  // count existing nested fields after page was loaded
  fieldsCount = $('form .fields').length;
  toggleAddLink();
})