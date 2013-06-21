<!doctype html>
 
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Donation</title>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  <script type="text/javascript" src="https://js.stripe.com/v1/"></script>
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
  <style>
    body { font-size: 62.5%; }
    label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
  </style>
  <script>
  Stripe.setPublishableKey('pk_test_zgD2MMiajKbdpAxdZl0VCnuD');
	 
   var stripeResponseHandler = function(status, response) {
     var $form = $('#payment-form');

     if (response.error) {
       // Show the errors on the form
       $(".ui-dialog-buttonpane button:contains('Donate')").attr("disabled", false).removeClass('ui-state-disabled');
       $form.find('.payment-errors').text(response.error.message);
     } else {
       // token contains id, last4, and card type
       
       var token = response.id;
       // Insert the token into the form so it gets submitted to the server
       $form.append($('<input type="hidden" name="stripeToken" />').val(token));
       //$form.append($('<input type="hidden" name="amount" />').val($("amount").val()));
       // and re-submit
       $form.get(0).submit();
     }
   };
  $(function() {
	  
	  $('#payment-form').submit(function(e) {
	        var $form = $(this);
	 
	        // Disable the submit button to prevent repeated clicks
	        //$form.find('button').prop('disabled', true);
	        $(".ui-dialog-buttonpane button:contains('Donate')").attr("disabled", true).addClass("ui-state-disabled");
	 
	        Stripe.createToken($form, stripeResponseHandler);
	 
	        // Prevent the form from submitting with the default action
	        return false;
	   });
 
    $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 320,
      width: 250,
      modal: true,
      buttons: {
        "Donate": function() {
        	$('#payment-form').submit();	
        },
        Cancel: function() {
          $( this ).dialog( "close" );
        }
      },
      close: function() {
        allFields.val( "" ).removeClass( "ui-state-error" );
      }
    });
 
    $( "#donate" )
      .button()
      .click(function() {
        $( "#dialog-form" ).dialog( "open" );
      });
  });
  </script>
</head>
<body>
 
<div id="dialog-form" title="Pi Kappa Alpha">
 
  	<form action="Charge" method="POST" id="payment-form">
		<div class="payment-errors" style="color:red; margin-bottom:12px"></div>

		<div class="form-row">
			<label> <span>Card Number</span> <input type="text" size="20"
				data-stripe="number" style="width: 90%;" class="text ui-widget-content ui-corner-all" />
			</label>
		</div>

		<div class="form-row">
			<label> <span>CVC</span> <input type="text" size="4" data-stripe="cvc" style="width:35px;" class="text ui-widget-content ui-corner-all" />
			</label>
		</div>

		<div class="form-row">
			<span>Expiration (MM/YYYY)</span> 
			<br>
			<input type="text"
				size="2" data-stripe="exp-month" style="width:35px; display:inline-block;" maxlength="2" class="text ui-widget-content ui-corner-all" />
			 <span> / </span> <input type="text" size="4" data-stripe="exp-year" style="width:35px; display:inline-block;" maxlength="4" class="text ui-widget-content ui-corner-all" />
		</div>

		<div class="form-row">
			<label> <span>Amount (US$)</span> <input type="text" name="amount" style="width:50%;" size="8" data-stripe="amount" class="text ui-widget-content ui-corner-all" />
			</label>
		</div>

	
	</form>
</div>
 
<button id="donate">Donate</button>
 
 
</body>
</html>