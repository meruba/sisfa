jquery ->
	$('#proveedors').dataTable
		sPaginationType: "full_numbers"
		bJQueryUI: true
		bProcessing: true
		bServerSide: true
		sAjaxSource: $('#proveedors').data('source')