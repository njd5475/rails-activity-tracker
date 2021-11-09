# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#

#= require moment
#= require moment-timezone
#= require chartjs
#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require bootstrap
#= require turbolinks
#= require react
#= require react-bootstrap
#= require components
#= require models
#= require_tree .

# request permission on page load
document.addEventListener 'DOMContentLoaded', () ->
  if !Notification
    alert('Desktop notifications not available in your browser. Try Chromium.')
    return

  if Notification.permission != "granted"
    Notification.requestPermission()

notifyMe = () ->
  if Notification.permission != "granted"
    Notification.requestPermission()
  else
    notification = new Notification 'Notification title',
      icon: 'http://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png',
      body: "Hey there! You've been notified!"

    notification.onclick = () ->
      window.open("http://stackoverflow.com/a/13328397/1269037")
