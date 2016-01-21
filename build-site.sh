#!/bin/bash

PROJECT_NAME=drupalorgnz # Used as the name of the install profile also.
PROJECT_DIR=/var/www/drupal_org_nz
PROFILE_DIR=$PROJECT_DIR/drupalorgnz-profile
SITE_ROOT=$PROJECT_DIR/docroot
SITE_NAME=d8.drupalorgnz.dd
SITE_DIR=$SITE_ROOT/sites/$SITE_NAME

DB_URL="mysql://drupaluser:@127.0.0.1:33067/drupalorgnz_d8"
# The DB Superuser credentials are only needed for a fully automated from-scratch install
# If you have already created the DB correctly, it's not needed.
DB_SU=drupaluser
DB_SU_PW=""

#############################################################

DRUSH_CMD="drush8 --root=$SITE_ROOT --uri=http://$SITE_NAME "

if [ -d "$SITE_DIR" ] ; then
  echo "Remove existing site database"
  $DRUSH_CMD sql-drop
fi

if [ -d "$SITE_ROOT" ] ; then
  echo "Remove existing codebase.."
  rm -rf "$SITE_ROOT"
fi

if [ ! -d "$SITE_ROOT" ] ; then
  echo "Remaking codebase"
  $DRUSH_CMD make "$PROFILE_DIR/build-drupalorgnz.make" $SITE_ROOT
  echo "Using local copy of the install profile"
  # cp -r "$PROFILE_DIR" $SITE_ROOT/profiles
  ln -s "$PROFILE_DIR" "$SITE_ROOT/profiles/$PROJECT_NAME"

fi

echo "Creating site"
# site-install fails if we don't copy settings.php (default) first?
# That Feels wrong.
cp "${SITE_ROOT}/sites/default/default.settings.php" "${SITE_ROOT}/sites/default/settings.php"
# Previous installs sometimes locked these permissions from ourself.
chmod -R u+w "${SITE_ROOT}/sites/"

echo $DRUSH_CMD site-install \
  --db-url="$DB_URL" \
  --site-name="$PROJECT_NAME" \
  --sites-subdir="$SITE_NAME" \
  --account-name="phpuser" --account-pass="web" \
  $PROJECT_NAME
