// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//

// TURBO
import '@hotwired/turbo-rails';

// Stimulus
import "../../javascript/controllers";

// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

/*
import "application/plugins/modernizr.js"
import "application/plugins/fastclick.js"

import "application/libraries/lodash.js"

import "application/namespace.js"

import "application/plugins/money.min.js"
import "application/plugins/_b.js"
import "application/plugins/payment.js"

import "application/foundation/foundation.js"
import "application/foundation/foundation.topbar.js"

import "application/app/graph_report.js"

import "application/app/inline_edit.js"

import "application/plugins/bride.js"
import "application/plugins/color.js"
import "application/plugins/tag.js"

import "application/forms.js"
import "application/links.js"
import "application/base.js"
 */
