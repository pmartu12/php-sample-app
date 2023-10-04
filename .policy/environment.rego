package main

deny[msg] {
   envPreprod := [ name | input[i].path == ".env.preprod"; name := input[i].contents ]
   envProd := [ name | input[i].path == ".env.prod"; name := input[i].contents ]

   count(envPreprod[0]) != count(envProd[0])

   msg = "Env preprod and prod should contain the same number of keys"
}

#deny[msg] {
#
#   input[_].contents[i]
#
#   regex.match("/[A-z]*CLIENT[A-z]*|[A-z]*SECRET[A-z]*", i)
#
#   msg = "Envs should not contain clientId and Secret"
#}

