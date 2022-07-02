Feature: test file


# api test
  # test the end points on given api url
  # 15 api end point
  # get, put, post, patch delete requests
  # positive and negative tests for all end points
  # what is our acceptance criteria
  # acceptance criteria provided by developer
  # sarmad: he wants us to be able to make a successful request on each of the end points
  # and he wants to see that we receive the expected status code and the expected payload response, and
  # would like the test to assert on two objects in the payload response
  # he wants it to be the same as the website and
  # along with the assert, print them on the screen

  #find a specific string in the entire data response
  #find a specific string in the entire json response karate

Feature: test file


  Scenario: positive test against url- LIST USERS with method get asserting 200 response

    Given url 'https://reqres.in/api/users?page=2'
    When method get
    Then status 200
    * def result = response
    And print result.data[1].first_name
    And match result.data[1].first_name == "Lindsay"
    And print result.page
#    And match response == expectedOutput
    And match response.data[1] contains {"first_name" : "Lindsay"}
    Given path 'data'

  Scenario: negative test against url - LIST USERS with method get asserting non-200 response
    Given url 'https://reqres.in/api/users?page=2'
    When method get
    Then status 300

  Scenario: get a SINGLE USER
    Given url 'https://reqres.in/api/users/2'
    When method get
    Then status 200
    And print response.data.last_name == "Weaver"
    And match response.data contains {"last_name" : "Weaver"}

  Scenario: get a SINGLE USER in a NEGATIVE test
    Given url 'https://reqres.in/api/users/2'
    When method get
    Then status 300

  Scenario: get a correct 404 response
    Given url 'https://reqres.in/api/users/23'
    When method get
    Then status 404

  Scenario: get a NEGATIVE 404 response
    Given url 'https://reqres.in/api/users/23'
    When method get
    Then status 304

  Scenario: Get list <resource>
    Given url 'https://reqres.in/api/unknown'
    When method get
    Then status 200
    And print response.data[2].name
    * def mortus = response
    And match mortus.data[2].name == "true red"
    And match response.data[2] contains {"name" : "true red"}

  Scenario: Get  NEGATIVE list <resource>
    Given url 'https://reqres.in/api/unknown'
    When method get
    Then status 404

  Scenario: Get single <resource>
    Given url 'https://reqres.in/api/unknown/2'
    When method get
    Then status 200
    And print response.data.name
    * def find = response
    And match find.data.name == "fuchsia rose"
    And match find.data contains {"name" : "fuchsia rose"}

  Scenario: Get NEGATIVE single <resource>
    Given url 'https://reqres.in/api/unknown/2'
    When method get
    Then status 404

  Scenario: Get single <resource> 404 error
    Given url 'https://reqres.in/api/unknown/23'
    When method get
    Then status 404

  Scenario: Get NEGATIVE single <resource> 404 error
    Given url 'https://reqres.in/api/unknown/23'
    When method get
    Then status 204

  Scenario: Create a new user in the article
    Given url 'https://reqres.in/api/users'
    And request {"name": "morpheus", "job": "leader" }
    When method Post
    Then status 201
    And print response.name
    * def laugh = response
    And match laugh.name == "morpheus"
    And match response contains {"name" : "morpheus"}

  Scenario: Create a NEGATIVE new user in the article
    Given url 'https://reqres.in/api/users'
    And request {"name": "morpheus", "job": "leader" }
    When method Post
    Then status 401

  Scenario: use a put request
    Given url 'https://reqres.in/api/users/2'
    When request { "name": "morpheus", "job": "zion resident" }
    And method put
    Then status 200
    And print response.job
    * def naught = response
    And match naught.job == "zion resident"
    And match naught contains {"job" : "zion resident"}

  Scenario: use a NEGATIVE put request
    Given url 'https://reqres.in/api/users/2'
    When request { "name": "morpheus", "job": "zion resident" }
    And method put
    Then status 400

  Scenario: Create and delete an Delete an article
    Given url 'https://reqres.in/api/users'
    And request {"name": "morpheus", "job": "leader" }
    When method Delete
    Then status 204

  Scenario: Create a NEGATIVE and delete an Delete an article
    Given url 'https://reqres.in/api/users'
    And request {"name": "morpheus", "job": "leader" }
    When method Delete
    Then status 404

  Scenario: Post a register successful request
    Given url 'https://reqres.in/api/register'
    And request { "email": "eve.holt@reqres.in", "password": "pistol" }
    When method Post
    Then status 200
    And print response.token
    * def fraught = response
    And match fraught.token == "QpwL5tke4Pnpja7X4"
    And match fraught contains {"token" : "QpwL5tke4Pnpja7X4"}

  Scenario: Post a NEGATIVE register successful request
    Given url 'https://reqres.in/api/register'
    And request { "email": "eve.holt@reqres.in", "password": "pistol" }
    When method Post
    Then status 400

  Scenario: Post an unsuccessful register request
    Given url 'https://reqres.in/api/register'
    And request '{ "email": "sydney@fife" }'
    When method Post
    Then status 400

  Scenario: Post an unsuccessful register request
    Given url 'https://reqres.in/api/register'
    And request '{ "email": "sydney@fife" }'
    When method Post
    Then status 200

  Scenario: successful login
    Given url 'https://reqres.in/api/login'
    And request { "email": "eve.holt@reqres.in", "password": "cityslicka" }
    When method Post
    Then status 200
    And print response.token
    * def lot = response
    And match lot.token == "QpwL5tke4Pnpja7X4"

  Scenario: NEGATIVE successful login
    Given url 'https://reqres.in/api/login'
    And request { "email": "eve.holt@reqres.in", "password": "cityslicka" }
    When method Post
    Then status 400

  Scenario: Login Unsuccessful
    Given url 'https://reqres.in/api/login'
    And request { "email": "peter@klaven" }
    When method Post
    Then status 400
    And print response.error
    * def firor = response
    And match firor.error == "Missing password"
    And match firor contains {"error" : "Missing password"}

  Scenario: Login NEGATIVE Unsuccessful
    Given url 'https://reqres.in/api/login'
    And request { "email": "peter@klaven" }
    When method Post
    Then status 200

  Scenario: Delayed response
    Given url 'https://reqres.in/api/users?delay=3'
    When method get
    Then status 200
    And print response.data[4].avatar
    * def priority = response
    And match priority.data[4].avatar == "https://reqres.in/img/faces/5-image.jpg"
    And match priority.data[4] contains {"avatar" : "https://reqres.in/img/faces/5-image.jpg"}

  Scenario: Delayed NEGATIVE response
    Given url 'https://reqres.in/api/users?delay=3'
    When method get
    Then status 400

  Scenario: Don't remember what this one is
    Given url 'https://reqres.in/api/unknown'
    When method get
    Then status 200
  Scenario: Get list <resource>
    Given url 'https://reqres.in/api/unknown'
    When method get
    Then status 200
#find a way to print out payload response
  #AND HOw to print out two specific things
  #assert on those two different things





