// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';

// TODO: Fix Luxan
// import { DateTime as luxon } from "luxon";
// console.log(luxon);

import 'list';
import 'jquery';

// TODO: Convert document.ready to short syntax
// n.b.: convert document.ready( to document.on('turbo:load',
// `.ready(` => `.on('turbo:load',`
import 'custom/cmu';
import 'controllers';

import "pwa";
