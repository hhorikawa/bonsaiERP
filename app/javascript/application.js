/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Import Rails UJS for Rails 6
import Rails from '@rails/ujs';
Rails.start();

// Import Active Storage
import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

// Import Action Cable for WebSockets
import '@rails/actioncable';

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

console.log('BonsaiERP Rails 6 with Webpacker initialized');

//= require plugins/modernizr.js
//= require plugins/fastclick.js
//= require jquery/jquery-ui-1.10.1.custom.js

//= require libraries/lodash.js

//= require jquery/select2.js
//= require jquery/flot/jquery.flot.js
//= require jquery/flot/jquery.flot.time.js
//= require jquery/jquery.cookie.js
//= require jquery/jquery.mask.js
//= require jquery/jquery.minicolors.js
//= require jquery/jquery.scrollTo.js
//= require jquery/jquery.placeholder.js
//= require jquery/jquery.extras.js
//= require jquery/notify.js

//= require namespace.js

//= require plugins/money.min.js
//= require plugins/_b.js
//= require plugins/payment.js

//= require bootstrap/bootstrap-dropdown.js
//= require bootstrap/bootstrap-tooltip.js
//= require bootstrap/bootstrap-modal.js
//= require bootstrap/bootstrap-popover.js
//= require bootstrap/bootstrap-collapse.js
//= require bootstrap/bootstrap-tab.js
//= require bootstrap/bootstrap-button.js

//= require foundation/foundation.js
//= require foundation/foundation.topbar.js

//= require app/graph_report.js

//= require app/inline_edit.js

// Angular
//= require angular/angular-file-upload.min.js
//= require_tree ./config
//= require_tree ./filters
//= require_tree ./controllers
//= require_tree ./services
//= require_tree ./directives

//= require plugins/bride.js
//= require plugins/color.js
//= require plugins/tag.js

//= require forms.js
//= require links.js
//= require base.js
