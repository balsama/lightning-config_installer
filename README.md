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
* Config must not have direct dependencies on a profile.
* For ease of use, your settings file should not contain the profile key 
* patchs