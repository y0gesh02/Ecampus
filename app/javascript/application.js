// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "jquery";
import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";
import $ from "jquery";

window.jQuery = jquery;
window.$ = jquery;
//= require jquery
console.log("jQuery");
