package main

test_ShouldFailWithClintIdAndSecret {
  deny["Envs should not contain clientId and Secret"] with input as
  [
          {
                  "path": ".env.preprod",
                  "contents": {
                          "CLIENT_ID": "73297249",
                  }
          },
          {
                  "path": ".env.prod",
                  "contents": {
                          "APP_SECRET": "core",
                  }
          }
  ]
}

test_ShouldFailWithClintIdAndSecret {
  deny["Env preprod and prod should contain the same number of keys"] with input as
  [
          {
                  "path": ".env.preprod",
                  "contents": {
                          "APP_TEST": "73297249",
                  }
          },
          {
                  "path": ".env.prod",
                  "contents": {
                          "APP_ENV": "core",
                          "APP_TEST": "73297249",
                  }
          }
  ]
}
