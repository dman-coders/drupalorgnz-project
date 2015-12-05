# DigitalOcean hosting

When your keys are installed, you should usually connect via drush site-alias

     drush @taranto ssh

Which may be equivalent to:

     ssh aegir@taranto.coders.co.nz

For sysadmin, use:

     ssh root@taranto.coders.co.nz


# Info

Originally built with Vagrant + DigitalOcean API ( see /vagrant )

## Stats 2015-12

Description:    **Ubuntu** 14.04.3 LTS
Codename:       trusty

Package: **php5**
Version: 5.5.9+dfsg-1ubuntu4.14

Package: **apache2**
Version: 2.4.7-1ubuntu4.8

Package: **mysql-server**
Version: 5.5.46-0ubuntu0.14.04.2


# Drush

Drush Version   :  8.1-dev

Installed at:

    /var/aegir/.composer/vendor/bin/drush

Drush dev-master (8.x) was installed for the aegir account using the process:

    composer global require "drush/drush:dev-master"


## Aegir quirks and bonuses

The live site is largely managed/deployed via aegir
 (though local tweaks may also be applied).
This should have no huge effect on development,
 apart from some quirks with the settings.php file seen on live,
 and the structure of (managed) vhost files if you go looking.
The aegir hostmaster is aegir1, running drush4, on a firewalled box elsewhere,
so we just will not mess with that at all when trying to sort out Drupal8 issues.

Things to know about aegir-managed sites :

It has Apache `AllowOverride` OFF by default, and modifications to `.htaccess`
 will not take immdiate effect.
Instead it will Apache `include` the .htaccess file, so requires an Apache
 restart. We will probably override that when setting up our own vhost.
 @see `/var/aegir/config/server_*/apache/platform.d/*`

## Apache

The aegir user has access to maintain the vhosts (no sudo)
 Vhost files and other aegir confs are in and around:

    /var/aegir/config/server_tarantocodersconz/apache/vhost.d/sandbox.drupal.org.nz

Aegir user can restart Apache as needed (limited sudo, no password)

    aegir@taranto:~$ sudo apache2ctl restart

Aegir user has been added to the adm gorup to grant access to logs, so you can

    aegir@taranto:~$ tail /var/log/apache2/other_vhosts_access.log
    aegir@taranto:~$ tail /var/log/apache2/error.log