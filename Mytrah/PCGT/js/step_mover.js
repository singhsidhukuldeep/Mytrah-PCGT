// JavaScript Document


// Activate Next Step

$(document).ready(function() {
    
    var navListItems = $('ul.setup-panel li a'),
        allWells = $('.setup-content');

    allWells.hide();

    navListItems.click(function(e)
    {
        e.preventDefault();
        var $target = $($(this).attr('href')),
            $item = $(this).closest('li');
        
        if (!$item.hasClass('disabled')) {
            navListItems.closest('li').removeClass('active');
            $item.addClass('active');
            allWells.hide();
            $target.show();
        }
    });
    
    $('ul.setup-panel li.active a').trigger('click');
    
    // DEMO ONLY //
    $('#activate-step-2').on('click', function(e) {
        $('ul.setup-panel li:eq(1)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-2"]').trigger('click');
        $(this).remove();
    })
    
    $('#activate-step-3').on('click', function(e) {
        $('ul.setup-panel li:eq(2)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-3"]').trigger('click');
        $(this).remove();
    })
    
    $('#activate-step-4').on('click', function(e) {
        $('ul.setup-panel li:eq(3)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-4"]').trigger('click');
        $(this).remove();
    })
	$('#activate-step-5').on('click', function(e) {
        $('ul.setup-panel li:eq(4)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-5"]').trigger('click');
        $(this).remove();
    })
	$('#activate-step-6').on('click', function(e) {
        $('ul.setup-panel li:eq(5)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-6"]').trigger('click');
        $(this).remove();
    })
	$('#activate-step-7').on('click', function(e) {
        $('ul.setup-panel li:eq(6)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-7"]').trigger('click');
        $(this).remove();
    })
    
});

//adding and removing rows in filtering criteria

// Add , Delete row dynamically

     $(document).ready(function(){
      var i=2;
     $("#add_row").click(function(){
      $('#addr'+i).html("<td>"+i+"</td><td><select name='criteria"+i+"' id='criteria"+i+"' class='form-control'><option>WIND SPEED</option><option>WIND DIRECTION</option><option>WIND TEMPERATURE</option><option>HUMIDITY</option><option>PRESSURE</option><option>POWER</option><option>MANUAL STOP</option><option>TURBINE AVAILABILITY</option><option>GRID AVAILABILITY</option><option>FAULT</option><option>ROTOR RPM</option><option>PITCH ANGLE</option><option>FREQUENCY</option><option>RAIN</option><option>UP-FLOW ANGLE</option><option>EXTRA PARAMETER 1</option><option>EXTRA PARAMETER 2</option><option>EXTRA PARAMETER 3</option><option>EXTRA PARAMETER 4</option><option>EXTRA PARAMETER 5</option></select></td><td><input class='form-control' type='text' required name='min"+i+"' id='min"+i+"'  autocomplete='off' placeholder='Min'></td><td><input class='form-control' type='text' required name='max"+i+"' id='max"+i+"'  autocomplete='off' placeholder='Max'></td>");
      
      $('#tab_logic').append('<tr id="addr'+(i+1)+'"></tr>');
      i++; 
  });
     $("#delete_row").click(function(){
    	 if(i>1){
		 $("#addr"+(i-1)).html('');
		 i--;
		 }
	 });

});
