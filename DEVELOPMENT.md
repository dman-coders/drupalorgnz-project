For quicker folder syncs or hot development,
 you can try remotely mounting the server over sshfs.

Once you have your key installed, and sshfs on your dev machine,

     sshfs aegir@taranto.coders.co.nz:/var/www/drupalnetnz/sandbox \
       /var/www/drupal_org_nz/sandbox -o reconnect -o no_readahead
