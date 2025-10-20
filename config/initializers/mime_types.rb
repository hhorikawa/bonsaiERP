
# Mime type lookup is a one-way hash. You cannot assign multiple "respond_to" to the same mime type.
# Use `register_alias()`:
#   Mime::Type.register "text/richtext", :rtf
#   Mime::Type.register_alias "text/html", :iphone

# And write `config/initializers/custom_responder.rb`
# See https://techracho.bpsinc.jp/baba/2011_12_21/4846

Mime::Type.register_alias "text/html", :print

