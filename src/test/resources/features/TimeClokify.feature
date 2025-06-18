@TimeEntry
Feature: Time entry
  Background:
    And base url $(env.base_url_clockify)
    And header Content-Type = application/json
    And header x-api-key = $(env.xApiKey)

  @TimeSearch @OK
  Scenario: Query hours by user
    Given call WorkspaceClockify.feature@WorkspaceQuery
    And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
    When execute method GET
    Then the status code should be 200
    * define timeEntryId = $.[0].id
    #* define workSpaceID = $.[0].workspaceId
    And validate schema jsons/schemas/getHours.json


  @AddNewTime
  Scenario: Add new time entry
    Given call WorkspaceClockify.feature@WorkspaceQuery
    Given endpoint /v1/workspaces/{{workspaceId}}/time-entries
    And body jsons/bodies/addNewTime.json
    When execute method POST
    * print response
    Then the status code should be 201
    And validate schema jsons/schemas/addNewTime.json

  @UpdateTimeEntry @Ok
    Scenario Outline: Update time entry on workspace
    Given call TimeClockify.feature@TimeSearch
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
    And set value <description> of key description in body jsons/bodies/updateTimeEntry.json
    And set value <start> of key start in body jsons/bodies/updateTimeEntry.json
    And set value <end> of key end in body jsons/bodies/updateTimeEntry.json
    When execute method PUT
    * print response
    Then the status code should be 200
    And response should be $.description = <description>
    And response should be $.timeInterval.end = <end>
    And response should be $.timeInterval.start = <start>
    And validate schema jsons/schemas/updateTime.json
    Examples:
      | description      | end                  | start                |
      | TP Final LowCode | 2025-06-15T05:30:00Z | 2025-06-15T04:00:00Z |
      | TP Edition       | 2025-06-14T06:00:00Z | 2025-06-14T05:00:00Z |

  @DeleteTimeEntry @Ok
    Scenario: Delete all time entries for user on workspace
    Given call TimeClockify.feature@TimeSearch
    And endpoint /v1/workspaces/{{workSpaceID}}/time-entries/{{timeEntryId}}
    When execute method DELETE
    * print response
    Then the status code should be 204












      

  
