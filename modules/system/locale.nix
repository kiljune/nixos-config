{
  pkgs,
  config,
  options,
  lib,
  inputs,
  system,
  systemSettings,
  userSettings,
  ...
}: {
  # Set your time zone.
  #services.automatic-timezoned.enable = true; #based on IP location

  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale_ko;
    LC_IDENTIFICATION = systemSettings.locale_ko;
    LC_MEASUREMENT = systemSettings.locale_ko;
    LC_MONETARY = systemSettings.locale_ko;
    LC_NAME = systemSettings.locale_ko;
    LC_NUMERIC = systemSettings.locale_ko;
    LC_PAPER = systemSettings.locale_ko;
    LC_TELEPHONE = systemSettings.locale_ko;
    LC_TIME = systemSettings.locale_ko;
  };
}
