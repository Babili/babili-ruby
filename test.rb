require_relative "lib/babili"

Babili.configure do |config|
  config.api_scheme     = "http"
  config.api_host       = "42.42.42.42"
  config.api_port       = 8081
  config.platform_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJwbGF0Zm9ybSIsInN1YiI6IjA2NTFhOWE5LTRlMmQtNGFmYy1iNGNmLTEwMDQ5OWFmM2RjNCIsImRhdGEiOm51bGwsImV4cCI6MTQ2MDcxMzQzNiwiaXNzIjoiQmFiaWxpIiwiaWF0IjoxNDYwNjI3MDM2fQ.pai3vxAOPm0dK_JzVqup-_Xs954mcI3U3mwlRkYuHbG3P7P2GiFgzff8N-4tJuv69KDwRfFTEwoZar2ExwuZ-VdaaSnau3A5IEipGNIgPThdHqnrJBU3sS9uXesjShjVar9uR-2upem1sdATXtXH-74Itb3BxSvbXC3pIGUmFJSkgvlZGNY8ii2fp6qAHHY3avGsbjZ1K3-P0ESpI7yYS06GibePLixwKe4edyjIjJMRSf1DNw8rXvtCi8ur8OphffnhE9-Wlb2MwMLFl9_fHOsAkD4sNyRUsPq-AdXxhZKClTaRdpWvjsFmaC7bQWWD__e0-grPFh0hG6Z1QKxwPQ"
end

# User
# puts Babili::Platform::User.create({id: "ID"}).inspect


# Room
puts Babili::Platform::Room.create({id: "ID"}).inspect
