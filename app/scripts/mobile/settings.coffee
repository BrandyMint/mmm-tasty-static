TastySettings =
  version:  'v0.3.2'
  env:      'static-development'
  host:     'http://taaasty.ru/'
  api_host: 'http://taaasty.ru/api/'

console.log 'MobileTastyVersion', TastySettings.version

TastySettings.host     = localStorage.getItem('host')     if localStorage.getItem('host')?.length > 0
TastySettings.api_host = localStorage.getItem('api_host') if localStorage.getItem('api_host')?.length > 0

window.TastySettings = TastySettings