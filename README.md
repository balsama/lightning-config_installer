# Lightning + Configuration installer

This project tests sub-profiles of the [Lightning distribution](https://www.drupal.org/project/lightning) against the
[Configuration installer](https://www.drupal.org/project/config_installer) profile.

Do not use this project as a starting point for your own project.

## Problem/Motivation

> As a user I want to be able to install Drupal from a package of configuration that is maintained in git.


## Solutions
* ~~Manually change site UUIDs~~ (Sloppy)
* ~~Use --config-dir option with drush site-install~~ (Only supports minimal profile)
* ~~Use patch from Issue #2788777~~ (Config needs to be stored in profile directory)
* Use Configuration installer profile 👌

## Considerations when using the Config installer profile
* For ease of use, your settings file should not be writable by the installer
  and should *not* contain the `install_profile` key.
* The Config installer profile requires two patches in order to work properly
  with Drush 9.
* Config must not have direct dependencies on a profile. Lightning 3.0.1
  requires the patch in issue #2933445 to be compliant.

## Instructions
1. For new sites, install using the profile or sub-profile of choice.

  ```
  $ drush site-install lightning
  ```

1. Ensure that the `install_profile` key is *not* present in your settings.php
  file. Drupal will write this value by default, but it is not required in
  Drupal >= 8.3.0. You can prevent Drupal from writing it by disallowing write
  access to the settings file. If the installer wrote the profile during initial
  installation, you can manually delete it. Then revoke write access:
  
  ```
  $ chmod 444 docroot/sites/default/settings.php
  ```

1. Define the following patches in your composer.json file if you are using
  config_installer < 1.6.0 and/or lightning < 3.0.2.
  
  ```
  "patches": {
      "drupal/config_installer": {
          "2916090 - Support Drush 9":
          "https://www.drupal.org/files/issues/drush9-support-2916090-6.patch",
          "2935426 - Drush 9: Call to undefined function drush_generate_password":
          "https://www.drupal.org/files/issues/config_installer-drush_9_call_undefined_function_drush_generate_password-2935426-2.patch"
      },
      "drupal/lightning_layout": {
          "2933445 - user.role.layout_manager has dependency on Lightning":
          "https://www.drupal.org/files/issues/2933445.patch"
      }
  },
  ```

1. Add the Configuration installer profile to your codebase.

  ```
  $ composer require drupal/config_installer
  ```

1. Export your site's configuration.

  ```
  $ drush config-export
  ```

1. Use the Configuration installer profile in all subsequent site installs. The
  resulting install will run on the profile used in step 1. 

  ```
  $ drush site-install config_installer 
  ```
