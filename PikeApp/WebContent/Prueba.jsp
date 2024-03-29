<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Stripe Getting Started Form</title>

<!-- The required Stripe lib -->
<script type="text/javascript" src="https://js.stripe.com/v1/"></script>

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

<script type="text/javascript">
    Stripe.setPublishableKey('pk_test_zgD2MMiajKbdpAxdZl0VCnuD');
 
    var stripeResponseHandler = function(status, response) {
      var $form = $('#payment-form');
 
      if (response.error) {
        // Show the errors on the form
        $form.find('.payment-errors').text(response.error.message);
        $form.find('button').prop('disabled', false);
      } else {
        // token contains id, last4, and card type
        
        var token = response.id;
        // Insert the token into the form so it gets submitted to the server
        $form.append($('<input type="hidden" name="stripeToken" />').val(token));
        //$form.append($('<input type="hidden" name="amount" />').val($("amount").val()));
        // and re-submit
        //$form.get(0).submit();
      }
    };
 
    jQuery(function($) {
      $('#payment-form').submit(function(e) {
        var $form = $(this);
 
        // Disable the submit button to prevent repeated clicks
        $form.find('button').prop('disabled', true);
 
        Stripe.createToken($form, stripeResponseHandler);
 
        // Prevent the form from submitting with the default action
        return false;
      });
    });
  </script>
</head>
<body>
	<h1>Charge $10 with Stripe</h1>

	<form action="Charge" method="POST" id="payment-form">
		<span class="payment-errors"></span>

		<div class="form-row">
			<label> <span>Card Number</span> <input type="text" size="20"
				data-stripe="number" />
			</label>
		</div>

		<div class="form-row">
			<label> <span>CVC</span> <input type="text" size="4"
				data-stripe="cvc" />
			</label>
		</div>

		<div class="form-row">
			<label> <span>Expiration (MM/YYYY)</span> <input type="text"
				size="2" data-stripe="exp-month" />
			</label> <span> / </span> <input type="text" size="4" data-stripe="exp-year" />
		</div>

		<div class="form-row">
			<label> <span>Amount (US$)</span> <input type="text" name="amount" size="8" data-stripe="amount"/>
			</label>
		</div>

		<button type="submit">Submit Payment</button>
	</form>
</body>
</html>