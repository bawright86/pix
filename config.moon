import config from require "lapis.config"

config "development", ->
  port 8080
  postgresql_url "postgres://pix:pixplzpixplzpixplz@127.0.0.1/pix"
  redis {"127.0.0.1", 6379}
  session_name "pix_session"
  secret "ongalabongala pixala"
  imgpath "img"
  upload_size "64M"
  site "hveem.no"

config "production", ->
  port 80
  num_workers 4
  lua_code_cache "off"
