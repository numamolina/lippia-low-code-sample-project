@Buscando404 @Punto7
Feature: Buscando error "404 No encontrado"

  Background:
    Given base url $(env.base_url)
    And header Content-Type = application/json
    And header x-api-key = $(env.x_api_key)



@Buscando404Workspace @Punto7
  Scenario: Buscar Workspace -inexistente-
    And endpoint api/v1/workspaces/664c36dc7d59624baae8dd8e
    When execute method GET
    Then the status code should be 200




  Scenario Outline: Buscar proyecto por ID -inexistente-
    And endpoint v1/workspaces/$(env.workSpaceID)/projects/<IdProyecto>
    When execute method GET
    Then the status code should be 200

    Examples:
      | IdProyecto               |
      | 664e4723ca96041c2c4e45e1 |
#Original 664e4723ca96041c2c4e45e0
#400 Bad Request: "{"message":"Project doesn't belong to Workspace","code":501}"