#== Class: wildfly

class wildfly(
  $bind_address = "127.0.0.1",
  $bind_address_management = "127.0.0.1"
) inherits wildfly::params {

  class{'wildfly::install': } ->
  class{'wildfly::config': } ~>
  class{'wildfly::service': } ->
  Class["wildfly"]

}
