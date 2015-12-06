
# Prototype D8 site for migrating drupal.org.nz to

    http://d8.drupal.org.nz/

is ready to start messing with.

`@d8.drupal.org.nz`

`d8.drupal.org.nz.alias.drushrc.php`

    $aliases["d8.drupal.org.nz"] = array (
      'root' => '/var/www/drupalnetnz/d8/docroot',
      'uri' => 'd8.drupal.org.nz',
      'remote-host' => 'taranto.coders.co.nz',
      'remote-user' => 'aegir',
      'path-aliases' => array (
        '%drush' => '/var/aegir/.composer/vendor/drush/drush',
        '%drush-script' => '/var/aegir/.composer/vendor/bin/drush',
        '%site' => 'sites/default/',
      ),
    );

## Git

   git clone https://github.com/wiifm69/drupal.net.nz.git --branch=8.x drupalorgnz

