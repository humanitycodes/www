class SubscriptionForm extends React.Component

  render: ->
    $div do

      $form action: '', method: 'POST', id: 'payment-form',
        $span class-name: 'payment-errors'

        $div class-name: 'form-row',
          $label do
            $span 'Card Number'
            $input type: 'text', size: '20', 'data-stripe': 'number'

        $div class-name: 'form-row'
          $label do
            $span 'CVC'
            $input type: 'text', size: '4', 'data-stripe': 'cvc'

        $div class-name: 'form-row'
          $label do
            $span 'Expiration (MM/YYYY)'
            $input type: 'text', size: '2', 'data-stripe': 'exp-month'
          $span ' / '
          $input type: 'text', size: '4', 'data-stripe': 'exp-year'

        $button type: 'submit', 'Submit Payment'

      $script do
        type: 'text/javascript'
        src: 'https://js.stripe.com/v2/'

      $script do
        type: 'text/javascript'
        "Stripe.setPublishableKey('pk_test_6pRNASCoBOKtIshFeQd4XMUh')"
