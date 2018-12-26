Fourfive cbd

www.fourfivecbd.co.uk
Do get in contact at tech@fourfivecbd.co.uk

ToDO:
Salutation centering
Hovering
Product show dropdown oils
review line yellow
how they are ordered
link in top right
pundit
font
[DEPRECATION] You are using the default localization behaviour that will change in the next major release. Find out more - https://github.com/RubyMoney/money#deprecation







Strrategy

so normally on product show we run find or create. then we go to cart_create and we have a cart passed in the cart_id of the params.

This way, we will have to run find or create before the cart_create is triggered.
If we don't have a cart, then cart_id is nil. This currently will trigger an error.
Because find_cart will error. So can't we just run findorcreate

All the things we get: user, cart_id.
