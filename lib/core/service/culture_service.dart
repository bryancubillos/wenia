class CultureService {
  //  [Properties]
  String currentCulture = 'es';

  final Map<String, dynamic> _localResources = {
    // Menu
    "menu-coins" : [{
      "es":"Monedas"
    }],
    "menu-favorites" : [{
      "es":"Favoritas"
    }],
    "menu-profile" : [{
      "es":"Perfil"
    }],

    // Welcome
    "welcome-hi" : [{
      "es":"!Hola!"
    }],
    "welcome-title" : [{
      "es":"Bienvenido al mundo cripto"
    }],
    "welcome-login" : [{
      "es":"Inicia sesión"
    }],
    "welcome-second-title" : [{
      "es":"¡Explora el mundo cripto con Wenia!"
    }],
    "welcome-third-title" : [{
      "es":"Conéctate con Wenia y descubre COPW, nuestro activo digital estable, como la llave a oportunidades con otros cripto."
    }],

    // Login
    "security-login-title" : [{
      "es":"Iniciar sesión"
    }],
    "login-email" : [{
      "es":"Correo electrónico"
    }],
    "login-password" : [{
      "es":"Contraseña"
    }],
    "login-error-message" : [{
      "es":"Usuario o contraseña incorrectos"
    }],
    "login-action" : [{
      "es":"Iniciar sesión"
    }],
    "login-new-account" : [{
      "es":"¿No tienes una cuenta?"
    }],
    "login-new-account-title" : [{
      "es":"Crea una cuenta"
    }],
    "login-new-account-action" : [{
      "es":"Crear cuenta"
    }],
    "login-registrer-empty-information-email" : [{
      "es":"Por favor, ingrese su correo electrónico"
    }],
    "login-registrer-empty-information-password" : [{
      "es":"Por favor, ingrese su contraseña actual"
    }],
    "login-registrer-empty-information-password-new" : [{
      "es":"Por favor, ingrese su nueva contraseña"
    }],
    "login-registrer-empty-information-password-repeat" : [{
      "es":"Por favor, ingrese nuevamente su nueva contraseña"
    }],
    "login-registrer-email-min" : [{
      "es":"El correo electrónico debe tener al menos 6 caracteres"
    }],
    "login-registrer-password-min" : [{
      "es":"El contraseña actual debe tener al menos 6 caracteres"
    }],
    "login-registrer-password-min-new" : [{
      "es":"La contraseña nueva debe tener al menos 6 caracteres"
    }],
    "login-registrer-password-min-repeat" : [{
      "es":"Al repetir la contraseña debe tener al menos 6 caracteres"
    }],
    "login-registrer-success-notification-message" : [{
      "es":"¡Cuenta creada con éxito!"
    }],
    "login-registrer-error-message" : [{
      "es":"¡Ups lo sentimos!, ha ocurrido un error al crear la cuenta (Su correo electrónico ya está registrado)"
    }],
    "login-registrer-age-confirmation": [{
      "es":"Afirmo ser mayor de 18 años"
    }],
    "login-registrer-age-error-message": [{
      "es":"Debes ser mayor de 18 años para registrarte"
    }],
    "login-registrer-password-not-equal": [{
      "es":"Las contraseñas no coinciden (nueva y repetir nueva)"
    }],
    "login-registrer-password-are-equal": [{
      "es": "La contraseña actual y la nueva son iguales, por favor cambie la nueva contraseña"
    }],

    // Profile
    "profile-log-out-confirmation": [{
      "es":"¿Estás seguro de que deseas cerrar sesión?"
    }],
    "profile-log-out": [{
      "es":"Cerrar sesión"
    }],
    "profile-account": [{
      "es":"Cuenta"
    }],
    "profile-change-password": [{
      "es":"Cambiar contraseña"
    }],

    // Common
    "common-ok": [{
      "en": "Ok",
      "es": "Aceptar"
    }],
    "common-yes": [{
      "en": "Yes",
      "es": "Si"
    }],
    "common-no": [{
      "en": "No",
      "es": "No"
    }],
    "common-save": [{
      "en": "Save",
      "es": "Guardar"
    }],
    "common-save-question": [{
      "en": "Do you want save?",
      "es": "¿Quieres guardar?"
    }],

    // Security
    "security-change-password-title": [{
      "es":"Nueva contraseña"
    }],
    "change-password-error-message" : [{
      "es":"¡Ups lo sentimos!, ha ocurrido un error al cambiar la contraseña"
    }],
    "change-password-success-message" : [{
      "es":"¡Contraseña cambiada con éxito!, por favor inicia sesión nuevamente"
    }],
    "security-change-password-current-password" : [{
      "es":"Contraseña actual"
    }],
    "security-change-password-new-password" : [{
      "es":"Nueva contraseña"
    }],
    "security-change-password-repeat-password" : [{
      "es":"Repita su nueva contraseña"
    }],
    "security-change-password-action" : [{
      "es":"Cambiar contraseña"
    }],

    // Account
    "account-title": [{
      "es":"Cuenta"
    }],
    "account-email" : [{
      "es":"Correo electrónico"
    }],
    "account-name" : [{
      "es":"Nombre"
    }],
    "account-id" : [{
      "es":"ID"
    }],
    "account-birthday" : [{
      "es":"Fecha de nacimiento"
    }],
    "account-save-action" : [{
      "es":"Guardar"
    }],
    "account-save-success" : [{
      "es":"Usuario guardado con éxito"
    }],
    "account-save-error" : [{
      "es":"¡Ups lo sentimos!, ha ocurrido un error al guardar el usuario"
    }],

    // Crypto
    "crypto-title" : [{
      "es":"Monedas"
    }],
    "crypto-search" : [{
      "es":"Buscar"
    }],
    "crypto-no-data" : [{
      "es":"Sin información"
    }],
  };

  // [Singleton]
  static final CultureService _instance = CultureService._constructor();

  factory CultureService() {
    return _instance;
  }
  
  // [Constructor]
  CultureService._constructor();

  // [Methods]
  getLocalResource(String keyResource) {
    String result = "";

    if (_localResources.containsKey(keyResource)) {
      result = _localResources[keyResource][0][currentCulture];
    }

    return result;
  }
}