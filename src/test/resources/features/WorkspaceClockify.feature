@Workspace
Feature: Workspace

  @WorkspaceQuery @Ok
  Scenario: Successful workspace query
    Given base url $(env.base_url_clockify)
    And endpoint /v1/workspaces
    And header Content-Type = application/json
    And header x-api-key = $(env.xApiKey)
    When execute method GET
    * print response
    Then the status code should be 200
    * define workspaceId = $.[1].id
    * define userId = $.[1].memberships.[0].userId
