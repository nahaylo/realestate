
jQuery(document).ready(function() {jQuery('a[rel*=facebox]').facebox()});


$(document).ready(function(){
    $('.data-table').dataTable({
       "bPaginate": false,
        "aoColumns": [
			null,
			null,
			null,
			{ "sType": "numeric-comma" },
			null,
            null,
			null,
			null
		]
    });
});

