# Migration

Notes of performing and automating a migration of drupal.org.nz from D7 to D8.

Once you have a working local copy of the live d7 site,
 or access to its database, you can look at doing a D8 migration.

## Set up a working D8 site

See online instructions. Good luck.

Up to you how you set up the database and database user and access.

Importantly, don't spend too much time preparing the new site before importing the old content...

However, If starting with 'minimal' install profile, then you will have to choose and enable at least a good handful of modules to upgrade to...
Actually, just don't use 'minimal', it's hopeless.


## Requirements

* drush8
* PHP 5.5.9+

## Migrating

[Preparing an upgrade from Drupal 6 or 7 to Drupal 8](https://www.drupal.org/node/2350603)

> I use drush8 as an alias to drush/dev-master exclusively here,
   to remind you that you need the latest version.

> Mentions of `d8.drupalorgnz.dd` are to my local DevDesktop (DD) install.
  You should substitute as appropriate.

    // Your already-working D8 site path here
    cd /var/www/drupal_org_nz/d8/sites/d8.drupalorgnz.dd/

    drush8 dl migrate_upgrade
    drush8 en -y migrate_upgrade

Visit /upgrade on the site, and follow the process there.


### Via drush (better, but scarier)

Read [Executing an upgrade from Drupal 6 or 7 to Drupal 8](https://www.drupal.org/node/2257723)

    drush8 dl migrate_tools migrate_upgrade
    drush8 en -y migrate_tools

    drush8 migrate-upgrade --legacy-db-url=mysql://drupaluser:@127.0.0.1:33067/drupalorgnz_d7 --legacy-root=http://drupal.org.nz --configure-only

    drush8 migrate-status

O_o !? OK, that's why the GUI may be better for us the first few times around this track.

To find the old legacy URL, I went

     drush site-alias  @drupal.org.nz --with-db --show-passwords
    drush migrate-upgrade --legacy-db-url=mysql://drupalorgnz_0:thepassword@taranto.coders.co.nz/drupalorgnz_0 --legacy-root=http://drupal.org.nz --configure-only


If you hit problems, Read [Executing an upgrade from Drupal 6 or 7 to Drupal 8](https://www.drupal.org/node/2257723)

## Next steps

At this point, we have got _content_ available, with the known fields migrated.
_users_ also seem to have come across.

## Audit/risks

From looking at the missed modules needin installing upgrading or replacing:

* Views will not be ported, therefore assume view-related tech will have to be rebuilt anyway.


Many goodies can be ignored. Noted risks are

* Addressfield is needed - investigate
* Date (investigate)
* Display_suite
* email_field (check vs core)
* entityreference - in core, migrate path not here yet? **
* Field slideshw - NOT - look for equvalents or demote out of MVP.
* file_entity - probably core? Investigate if the medtadate comes over
* global redirect - maybe?
* google analytics - contrib available!


* Future, maybe, unknown - does not impact MVP release.

* BEF (better exposed filters)
* Feeds - re-evaluate importance
* block_class - useful if not in core already. 8.x-dev exists (theme enhancement)
* field_group - migrate path needed but - is theme support only


## TODO

So, the automated process does demonstrably get us a good way forward.
But now comes the site-specific massaging.

* **Nodes exist, and seem to have data, but no content displays**
  = The text format didn't come forwards.



## Reset

When things go wrong on the target and you need a clean slate.

    cd /var/www/drupal_org_nz/d8/sites/d8.drupalorgnz.dd
    drush8 site-install standard --account-name=phpuser --account-pass=web
    drush8 en -y migrate_upgrade

This will re-use your existing database (dropping the tables first)
so you don't have to do the credentials and database setup again.