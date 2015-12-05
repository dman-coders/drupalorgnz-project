A vanilla Drupal 8 sandbox is installed at

    http://sandbox.drupal.org.nz/

We may reset it back to scratch when needed.

user: drupal8nz
pass: (ask the gang)


Create a local alias file:

`sandbox.drupal.org.nz.alias.drushrc.php`

    <?php
    $aliases["sandbox.drupal.org.nz"] = array (
      'root' => '/var/www/drupalnetnz/sandbox',
      'uri' => 'http://sandbox.drupal.org.nz',
      'remote-host' => 'taranto.coders.co.nz',
      'remote-user' => 'aegir',
      'path-aliases' => array (
        '%drush' => '/var/aegir/.composer/vendor/drush/drush',
        '%drush-script' => '/var/aegir/.composer/vendor/bin/drush',
        '%site' => 'sites/default/',
      ),
    );

Means you should be able to:

    drush @sandbox.drupal.org.nz status

and see results including:

     Drupal version                  :  8.0.1
     Site URI                        :  http://sandbox.drupal.org.nz
     Drupal bootstrap                :  Successful
     Drush script                    :  /var/aegir/.composer/vendor/drush/drush/drush.php
     Drush version                   :  8.1-dev
     Drupal root                     :  /var/www/drupalnetnz/sandbox
     Site path                       :  sites/default
     File directory path             :  sites/default/files

On the `taranto` server, the drush aliases `@sandbox` and `@sandbox.drupal.org.nz`
 are equivalent.

## Reset

Drush will let us restore to factory settings with:

    drush @sandbox.drupal.org.nz site-install \
      --account-name=drupalorgnz --account-pass="{ask the gang}" \
      standard
